#!/bin/bash

# TODO: add filemask
if [ $# -ne 2 ]; then
    echo "usage: $(basename "$0") old-text new-text"
    exit 1
fi

oldtext=$1
newtext=$2
echo "Replacing '$oldtext' with '$newtext'"
echo


find=find
sed=sed
if [[ "$OSTYPE" =~ darwin* ]]; then
    # on mac using GNU version
    find=gfind
    sed=gsed
fi

$find . -type f -iname '*.md' -not -path "*/.git/*" -print0 | while read -d $'\0' file; do
    diffout=$($sed -e "s|$oldtext|$newtext|" "$file" | diff "$file" -)
    [[ $? -eq 0 ]] && continue

    echo
    echo "Diff for $file:"
    echo "$diffout"

    while true; do
        echo
        read -u 2 -p "Replace (y/n)? " choice
        case "$choice" in
            y|Y ) echo "Replacing"; $sed -i "s|$oldtext|$newtext|" "$file" ;;
            n|N ) echo "Skipping";;
            * ) echo "Invalid choice"; continue;;
        esac
        break
    done
done
