#!/usr/bin/python
# From https://stackoverflow.com/questions/35658887/git-pre-commit-or-update-hook-for-stopping-commit-with-branch-names-having-case
import sys
import subprocess

branch = sys.argv[1]
old_commit = sys.argv[2]
new_commit = sys.argv[3]

# order is important, for update hook: refname oldsha1 newsha1
print "Moving '%s' from %s to %s" % (branch, old_commit, new_commit)
print "Branch '%s' " %(branch)
print "old_commit '%s' " %(old_commit)
print "new_commit '%s' " %(new_commit)

def git(*args):
    return subprocess.check_call(['git'] + list(args))
    #if %(branch).lower() in []array of results from the git for-each-ref
    #sys.exit(1)

def get_name(target):
    p = subprocess.Popen(['git', 'for-each-ref', 'refs/heads/'], stdout=subprocess.PIPE)
    for line in p.stdout:
        sha1, kind, name = line.split()
        if sha1 != target:
            continue
        return name
    return None

if __name__ == "__main__":
    #git("status")
    #git("for-each-ref" , "refs/heads/" , "--format='%(refname:short)'")
    #cmd = git("for-each-ref" , "--format='%(refname:short)'")
    cmd = git("for-each-ref" , "--format='%(refname:short)'")
    #print cmd
    #print get_name(branch)
    #print get_name(old_commit)
    print get_name(new_commit)
sys.exit(0)
