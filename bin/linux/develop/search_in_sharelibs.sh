#!/bin/bash
if [ -z $1 ]; then
    echo "Usage: script <symbol> [dir]"
    exit 1
fi
SYMBOL=$1

DIR=.
if [ ! -z $2 ]; then
    DIR=$2
fi

find $DIR -name "*.so" -print0 | while read -d $'\0' file
do
#    echo "- $file"
    readelf -Ws $file | awk '{ if ($3 != 0) { print }}' | grep $SYMBOL
    if [ $? -eq 0 ]; then
        echo "+ $file"
    fi
done
