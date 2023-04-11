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
if [ ! -d "$1/.git" ]; then
	echo "target directory must be git repo"
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
NAME=`basename $1`

cmd "mv $NAME/.git ."
cmd "rm -rf $NAME"
cmd "mv .git $NAME.git"
cmd "cd $NAME.git"
cmd "git config --bool core.bare true"
echo "ALL DONE"
