#!/usr/bin/perl

=head1 NAME
	update_submodules.pl

	Script to download and/or update submodule links for Git/Gerrit.

=head1 USAGE
	If you run script without mandatory parameters, then it shows help information.

  $ update_submodules.pl
  usage: update_submodules.pl [--help] --path path --host host [--port port]
         [--user user] [--git gitcmd] [--prefix prefix] [--skip regexp]
		 [--fetch repo] [--hooks list]

  Help and support tool for git/gerrit/submodules at Luxoft.

  optional arguments:
    --help           Show this help message and exit
    --path   path    Path to repo's folder
    --host   host    Connect to the Gerrit server on the given host
    --port   port    The TCP/IP port number to use for the connection
    --user   user    The Gerrit user name to use when connecting to the server
    --git    gitcmd  Path to Git executable
    --prefix prefix  Prefix is appended for repo's name in server request
    --skip   regexp  Skip submodules with names according regexp
    --fetch  repo    If path is empty then fetch repo from server
    --hooks  list    Download specified list of hooks from server (valid values: applypatch-msg,
                     commit-msg, post-commit, post-receive, post-update, pre-applypatch, pre-commit,
                     pre-push, pre-rebase, prepare-commit-msg, update). Names are separated by comma.

  examples:
    Update links in submodules
    $ perl update_submodules.pl --path TEORA1 --host github.com --user git --prefix Luxoft/ --fetch SWIFT_int

    Fetch repo with hooks and update links in submodules
    $ perl update_submodules.pl --path Populus --host ppls-gerrit-01.luxoft.com --port 29418 --user msuslov --fetch Populus --hooks commit-msg

    Use prefix
    $ perl update_submodules.pl --path SWIFT_Tools --host github.com --user git --prefix Luxoft/ --fetch SWIFT_Tools

=head1 PARAMETERS
	You can specify next parameters:

	--path path
	Path is location of local copy of repository.

	--host host
	Repository's host.

	--port port
	Specify port to connect. Default value is 22. This value can be overriden by ssh config.
	Usually Git runs on port 22, Gerrit runs on port 29418.

	--user user
	Specify user login. Default value is your username. This value can be overriden by ssh config.

	--git gitcmd
	Path to Git's executable. Script try to find git in default locations and PATH. Use found location as default value. Otherwise 'git' is used.

	--prefix prefix
	Prefix is appended for repo's name in server request.

	--skip regexp
	Skip submodules with names according regexp. It requires if submodule doesn't exists anymore or server is temporary unavailable.

	--fetch repo
	If path is empty or non-exist folder, then you can fetch repo with specified name from server.

	--hooks list
	Specify one or more hook names (separating them by comma) to download them from server.
	Usually Gerrit use 'commit-msg' hook.
	'scp', 'chmod' commands must be in PATH.

=head1 SCRIPT LOGIC

	Script executes next steps:
	0) Clone repo if needed
	$ git clone ssh://username@host:port/Repository Folder
	$ cd Folder

	1) Find current git toplevel folder
	$ git rev-parse --show-toplevel

	2) Look for modules (in toplevel folder):
	$ cat .gitmodules
	[submodule "Name1"]
	  path = PathToName1
	  url = git://unavailable.server.com/git/Name1
	  branch = .
	[submodule "Name2"]
	  path = PathToName2
	  url = git://unavailable.server.com/git/Name2
	  branch = .
	There are two modules: "Name1", "Name2".

	3) For each module set URL to server with specific user name:
	$ git config submodule.Name1.url ssh://username@host:port/prefixName1
	$ git config submodule.Name2.url ssh://username@host:port/prefixName2

	4) Change URL inside each submodule:
	$ cd Name1
	$ git remote rm origin
	$ git remote add origin ssh://username@host:port/prefixName1
	$ cd ..

	$ cd Name2
	$ git remote rm origin
	$ git remote add origin ssh://username@host:port/prefixName2
	$ cd ..

	5) Update to latest changes (if we copy repo not from server):
	$ git submodule foreach git fetch --all

	6) Repeat steps 1-6 for all submodules, because they can contain own submodules.

=head1 AUTHOR
	Maxim Suslov <msuslov@luxoft.com>

=head1 KNOWN BUGS
	If connection is broken while download repo, then no possibility download again.
	Because folder isn't empty, then no fetch again.

	Command

=head1 TODO
	See todo in code

=head1 VERSION
	20140911
		[+] Add skip parameter
		[*] Fix slashes in path parameters according OS
		[*] Stop infinite loop when submodule was incorrectly delete

=cut

use strict;
use warnings;
use Getopt::Long;
use File::Basename;
use Cwd;
use File::Spec;
use File::Path;

use constant IS_WIN => ($^O eq 'MSWin32' || $^O eq 'dos');
my $prompt = IS_WIN ? '>' : '$';

sub find_git_exec {
	my @possible_location = IS_WIN ? (
		'c:\Program Files (x86)\Git\bin\git.exe',
		'c:\Program Files\Git\bin\git.exe',
		map { File::Spec->catfile($_, 'git.exe') } File::Spec->path(),
	) : (
		'/usr/bin/git',
		'/bin/git',
		map { File::Spec->catfile($_, 'git') } File::Spec->path(),
	);
	for my $location (@possible_location) {
		if (-e $location) {
			return $location;
		}
	}
	return IS_WIN ? 'git.exe' : 'git';
}

sub escape_path {
	my $path = shift;
	$path = '"' . $path . '"'
		if $path =~ m/ /;
	return $path;
}

sub fix_slashes_in_path {
	# Sometimes script run from MinGW or Cygwin environment, but slashes are from Windows style

	my $path = shift;
	if (IS_WIN) {
		$path =~ s!/!\\!g;
	}
	else {
		$path =~ s!\\!/!g;
	}
	return $path;
}

my $script = basename($0);

# parse arguments
my $help   = '';
my $path   = undef;
my $host   = undef;
my $port   = '';
my $user   = '';
my $git    = find_git_exec();
my $prefix = '';
my $skip   = '';
my $fetch  = '';
my $hooks  = '';

GetOptions(
	"help"     => \$help,
	"path=s"   => \$path,
	"host=s"   => \$host,
	"port=i"   => \$port,
	"user=s"   => \$user,
	"git=s"    => \$git,
	"prefix=s" => \$prefix,
	"skip=s"   => \$skip,
	"fetch=s"  => \$fetch,
	"hooks=s"  => \$hooks,
) or die("Error in command line arguments.\nUse '$script --help' for help\n");

# show help if mandatory parameters are omitted
unless ($path && $host) {
	print "error: mandatory parameters are omitted\n\n";
	$help = 1;
}

# validate parameters' values
$path = fix_slashes_in_path($path);
$git = escape_path($git);

unless (!$port || $port =~ /^\d+$/ && $port > 0 && $port <= 65535) {
	die("error: incorrect port '$port'\n");
}

if ($skip ne "") {
	eval { "" =~ $skip };
	if ($@) {
		die("error: incorrect regexp '$skip'\n");
	}
}

my @valid_hooks = ('applypatch-msg', 'commit-msg', 'post-commit', 'post-receive', 'post-update', 'pre-applypatch', 'pre-commit', 'prepare-commit-msg', 'pre-push', 'pre-rebase', 'update');
my %valid_hooks = map { $_ => 1 } @valid_hooks;
my @hooks = split /,/, $hooks;
for my $hook (@hooks) {
	unless ($valid_hooks{$hook}) {
		die("error: unknown hook '$hook'\n");
	}
}

# show help
if ($help) {
	my $usage = <<"EOF";
usage: update_submodules.pl [--help] --path path --host host [--port port]
                            [--user user] [--git gitcmd] [--prefix prefix]
                            [--skip regexp] [--fetch repo] [--hooks list]

Script to download and/or update submodule links for Git/Gerrit.
Version 20140910

optional arguments:
  --help           Show this help message and exit
  --path   path    Path to repo's folder
  --host   host    Connect to the Gerrit server on the given host
  --port   port    The TCP/IP port number to use for the connection
  --user   user    The Gerrit user name to use when connecting to the server
  --git    gitcmd  Path to Git executable
  --prefix prefix  Prefix is appended for repo's name in server request
  --skip   regexp  Skip submodules with names according regexp
  --fetch  repo    If path is empty then fetch repo from server
  --hooks  list    Download specified list of hooks from server (valid values: applypatch-msg,
                   commit-msg, post-commit, post-receive, post-update, pre-applypatch, pre-commit,
                   pre-push, pre-rebase, prepare-commit-msg, update). Names are separated by comma.

For more information see documentation in script.
EOF
	# todo: fix
	# http://stackoverflow.com/questions/956379/how-can-i-word-wrap-a-string-in-perl
	#$usage =~ s/^(.{0,79}(?:\s|$))/$1\n==/mg;
	#$usage =~ s/^(.{1,79}\S|\S+)\s+$/"$1\n" . " "x18/mge;
	print $usage;
	exit(0);
}

sub exec_git_helper {
	my $olddir = getcwd();
	my ($dir, $cmd) = @_;

	unless (chdir($dir)) {
		return;
	}
	open(F, '-|', $cmd) or die("error: can't exec '$cmd'\n");
	# a) got information
	# b) got error
	# fatal: Not a git repository (or any of the parent directories): .git

	local $/;
	my $res = <F>;
	$res =~ s!\n+$!!s; # chomp for several lines
	close F;

	if ($res =~ /fatal:/) {
		$res = undef;
	}

	# return unless defined wantarray;
	return wantarray ? ($res, $olddir) : $res;
}

sub find_git_folder {
	my $dir = shift;
	my ($res, $olddir) = exec_git_helper($dir, "$git rev-parse --git-dir");
	# $res contains path to .git folder; path can be either relative ('.git') or absolute ('d:/Work/Populus/.git')

	die("error: can't find .git folder in '$dir'\n")
		unless (defined $res);

	chdir $res;
	$res = getcwd();

	chdir $olddir;
	return $res;
}

sub find_git_toplevel {
	my $dir = shift;
	my ($res, $olddir) = exec_git_helper($dir, "$git rev-parse --show-toplevel");
	# $res contains absolute path to repo's toplevel folder

	die("error: can't find .git toplevel folder in '$dir'\n")
		unless (defined $res);

	chdir $res;
	$res = getcwd();

	chdir $olddir;
	return $res;
}

sub find_git_branch {
	my $dir = shift;
	my ($res, $olddir) = exec_git_helper($dir, "$git rev-parse --abbrev-ref HEAD");
	# $res contains absolute path to repo's toplevel folder

	die("error: can't find current branch in '$dir'\n")
		unless (defined $res);

	chdir $olddir;
	chomp $res;
	return $res;
}

# show used value
my $branch = -e $path && find_git_branch($path) || '<none>';
my $git_host = "ssh://" . ($user ? "$user\@" : "") . $host . ($port ? ":$port" : ""); # use user if any, use port if any
my $scp_host = ($port ? "-P $port " : "") . ($user ? "$user\@" : "") . $host; # port before, because host used in connection with other parameters

print <<"EOF";

Parameters
  path  : $path
  host  : $host
  port  : $port
  user  : $user
  git   : $git
  prefix: $prefix
  skip  : $skip
  hooks : $hooks

Internal info
  branch  : $branch
  git_host: $git_host
  scp_host: $scp_host

EOF

sub exec_cmd {
	my $cmd = shift;
	my $what = shift;

	print "$prompt $cmd\n";
	system($cmd);

	if ($? == 0) {
		print "$what: OK\n";
	}
	elsif ($? == -1) {
		print "$what: failed to execute, $!\n";
		exit 1;
	}
	elsif ($? & 127) {
		printf("$what: child died with signal %d, %s coredump\n", ($? & 127), ($? & 128) ? 'with' : 'without');
		exit 1;
	}
	else {
		printf("$what: child exited with value %d\n", $? >> 8);
		exit 1;
	}
}

sub exec_chdir {
	my $dir = shift;
	print "$prompt cd " . escape_path($dir) . "\n";
	chdir($dir) or die("error: can't change dir to '$dir': $!\n");
}

# Submodule was removed, but its record wasn't remove from .gitmodules.
# In that case git return folder of upper repository.
# Using seen folder hash we prevent recursion
my %seen_git_folders = ();

sub update_submodules {
	my $name = shift;
	my $dir = shift;

	if ($skip ne "" && defined($name) && $name =~ /$skip/) {
		print "\n=== Skipping '$name' submodule in '$dir' folder ===\n";
		return;
	}

	print "\n=== Processing" . (defined $name ? " '$name' submodule in" : "") . " '$dir' folder ===\n";

	my $toplevel = find_git_toplevel($dir);
	unless ($toplevel) {
		die("No git repository found in '$dir'\n");
	}

	if ($seen_git_folders{$toplevel}++) {
		die("error: process the same git folder twice\n(possibly submodule was removed incorrectly)\n");
	}

	# copy hooks for repo
	my $hook_folder = File::Spec->catfile(find_git_folder($dir), 'hooks', '');
	for my $hook (@hooks) {
		exec_cmd("scp -p $scp_host:hooks/$hook $hook_folder", "scp $hook");
		unless (IS_WIN) {
			exec_cmd("chmod u+x ${hook_folder}commit-msg", "chmod u+x $hook");
		}
	}

	# does any submodule?
	my $modules_file = File::Spec->catfile($toplevel, '.gitmodules');
	unless (-f $modules_file) {
		print "No submodules found for $dir\n";
		return;
	}

	open(F, '<', $modules_file) or die("Could not open '$modules_file' for read\n");
	undef $/;
	my $content = <F>;
	close F;

	# cd to toplevel folder
	my $olddir = getcwd();
	exec_chdir($toplevel);

	# find all submodules
	my @sections = split m!\[\s*submodule\s+"([^"]+)"\]!, $content;
	shift @sections if $sections[0] eq "";

	my %sections;
	while (@sections) {
		my $submodule = shift @sections;

		$content = shift @sections;
		while ($content =~ m!^\s*(\S+)\s*=\s*(.+?)\s*$!mgc) {
			$sections{$submodule}{$1} = $2;
		}

		# left only last name, i.e. "external/DevIL" => "DevIL"
		$sections{$submodule}{url} =~ m!([^/]+)$!;
		$sections{$submodule}{shortname} = $1;

		exec_cmd("$git config submodule.$submodule.url $git_host/$prefix$sections{$submodule}{shortname}", "git config submodule.$submodule.url");
	}

	exec_cmd("$git submodule init", "git submodule init");
	exec_cmd("$git submodule update", "git submodule update");

	for my $submodule (keys %sections) {
		print "\nSubmodule: $submodule\n";
		exec_chdir($sections{$submodule}{path});
		exec_cmd("$git remote rm origin", "git rm origin");
		exec_cmd("$git remote add origin $git_host/$prefix$sections{$submodule}{shortname}", "git add origin");
		exec_chdir($toplevel);
	}

	exec_cmd("$git submodule foreach git fetch --all", "git fetch --all");

	for my $submodule (reverse sort keys %sections) {
		update_submodules($submodule, $sections{$submodule}{path})
	}

	exec_chdir($olddir);
}

unless (-e $path) {
	mkpath($path) or die("error: can't create folder '$path': $!\n");
}

if (glob File::Spec->catfile($path, '*.*')) {
	# folder is not empty
	if ($fetch) {
		# need to fetch -> error
		die("error: can't fetch into non-empty folder '$path'\n");
	}
	else {
		update_submodules(undef, $path);
	}
} else {
	# if folder is empty
	if ($fetch) {
		# need to fetch -> OK
		exec_cmd("$git clone $git_host/$prefix$fetch $path", "git clone $fetch");
		update_submodules(undef, $path);
	}
	else {
		warn("warning: nothing to do in empty folder '$path'\n");
	}
}
