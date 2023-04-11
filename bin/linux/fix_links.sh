#!/bin/bash
# TODO: find former fix_links.sh

DIR=.
if [ ! -z $1 ]; then
    DIR=$1
fi
# TODO: remove trailing /

# find broken links
# find . -type l -exec sh -c "file -b {} | grep -q ^broken" \; -print


find $DIR -type l -lname '/*' -print0 | while read -d $'\0' file; do
    link_to=$(readlink "$file")
    # echo "$file -> $link_to"

    # remove first character (/)
    cut_link=$(echo $link_to | cut -c2-)
    # echo "$file -> $cut_link"

    new_target="$DIR/$cut_link"

    # skip if it is already relocated
    if [[ $link_to == $DIR/* ]]; then
        echo "skip already $file"
        # TODO: make it relative
        continue
    fi

    if [ ! -L ${new_target} ] && [ ! -e $new_target ]; then
        echo "$file -> $link_to"
        echo "warning: invalid target $new_target"
    fi

    # make them relative
    # relative=$(realpath --strip --relative-to $file $new_target)
    # echo "file: $file"
    # echo "target: $new_target"
    # echo "relative: $relative"
    # echo
    # ln -snf $relative $file

    # make them absolute
    echo "info: update $file -> $new_target"
    ln -snf $new_target $file
done

# clean messy links (with unnecessart ..)
symlinks -ct $DIR
