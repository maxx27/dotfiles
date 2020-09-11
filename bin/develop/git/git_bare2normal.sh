#!/bin/bash
# Author: Maxim Suslov
# Last updated: 2014.12.02

if [ "$1" == "" ]; then
	echo "usage: `basename $0` <dir>"
	exit 1
fi
if [ ! -d "$1" ]; then
	echo "argument should be a directory"
	exit 1
fi
if [ -d "$1/.git" ]; then
	echo "target directory must be bare repo"
	exit 1
fi

function cmd ()
{
	echo "$*"
	eval "$*"
	if [ $? -ne 0 ]; then
		exit 1
	fi
}

cd `dirname $1`
NAME_FROM=`basename $1`
NAME_TO=${NAME_FROM%.git}

cmd "mv $NAME_FROM .git"
cmd "mkdir $NAME_TO"
cmd "mv .git $NAME_TO"
cmd "cd $NAME_TO"
cmd "git config --bool core.bare false"
cmd "git checkout --force HEAD"
cmd "cd .."
echo "ALL DONE"
