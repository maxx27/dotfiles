#!/bin/bash
# Author: Maxim Suslov
# Last updated: 2014.12.02

if [[ "$1" == "" || "$2" == "" ]]; then
	echo "usage: `basename $0` <dir> <submodule>"
	exit 1
fi
if [ ! -d "$1" ]; then
	echo "argument should be a directory"
	exit 1
fi
if [ ! -d "$1/.git" ]; then
	echo "target directory must be git repo"
	exit 1
fi

cd "$1"
if ! grep -q "submodule \"$2\"" .gitmodules ; then
	echo "no module with name '$2' inside '$1'"
	exit 1
fi

function cmd ()
{
	echo "$1"
	eval "$1"
	# ignore error because most of commands to remove module can fail
}

# remove config entries
cmd "git config -f .git/config --remove-section submodule.$2"
cmd "git config -f .gitmodules --remove-section submodule.$2"
# remove directory from index
cmd "git rm --cached $2"
# delete unused files
cmd "rm -rf $2"
cmd "rm -rf .git/modules/$2" # || true for broken submodules
# commit
cmd "git add .gitmodules"
cmd "git rm $2"
cmd "git commit -m 'Remove submodule $2'"
echo "AMEND COMMIT"
