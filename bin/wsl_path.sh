#!/bin/bash -e

# bash is important. For /bin/sh:
# $ wsl_path.sh 'C:\Windows\System32\calc.exe'
# C:\Windows\System32
# last part got lost (don't know why, but suspect \c)

# Helper script to convert Windows path into WSL ones:
# $ wsl_path.sh 'C:\my\path'
# /mnt/c/my/path
#
# Support multiple paths
# $ wsl_path.sh 'C:\my\path' 'd:\aa\bb'
# /mnt/c/my/path
# /mnt/d/aa/bb
#
# Change directory (silently)
# $ wsl_path.sh -c 'C:\my\path'
# (do cd /mnt/c/my/path)

change=false

while [ $# -gt 0 ]; do
    while getopts c name; do
        case $name in
            c) change=true;;
        esac
    done
    [ $? -ne 0 ] && exit 1
    [ $OPTIND -gt $# ] && break

    shift $[$OPTIND - 1]
    OPTIND=1
    ARGS[${#ARGS[*]}]=$1
    shift
done

if [ ${#ARGS[*]} -eq 0 ]; then
    echo "usage: $(basename "$0") [-c] PATH1 PATH2 ..."
    exit 1
fi

if grep -qi mingw /proc/version; then
    prefix=/
elif grep -qi microsoft /proc/version; then
    prefix=/mnt/
else
    prefix=/
fi

for path in ${ARGS[*]}; do
    fix=$(echo "$path" | sed -E 's|\\|/|g' | sed -E "s|^([a-zA-Z]):/|$prefix\\l\\1/|")
    if $change; then
        cd $fix
    else
        echo "$fix"
    fi
done
