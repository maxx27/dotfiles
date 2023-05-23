#!/bin/bash
# from https://stackoverflow.com/questions/6841143/how-to-set-font-color-for-stdout-and-stderr

# color()(set -o pipefail;"$@" 2>&1>&3|sed $'s,.*,\e[31m&\e[m,'>&2)3>&1
# color $*

echo -en "\033[31m"  # red
eval $* | while read line; do
    echo -en "\033[37m"  # white
    echo $line
    echo -en "\033[31m"  # red
done
echo -en "\033[0m"  # reset color
