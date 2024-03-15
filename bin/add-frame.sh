#!/bin/bash -e

# Add frame to the image.
# It creates a backup image (in the same directory) with suffin "...-original" in the filename (it doesn't contain frame).

# https://askubuntu.com/questions/819482/how-to-add-a-border-using-imagemagick/1480001#1480001
if [ -z "$1" ]; then
    echo "Usage: $(basename $0) <image>"
    exit 1
fi

file="$1"
if [[ "$file" == *"-original"* ]]; then
    original=$file
    file=${file//-original/}
else
    extension=${file##*.}
    original="${file%.$extension}-original.$extension"
fi

if [ ! -e "$original" ]; then
    mv "$file" "$original"
fi

# required ImageMagick
convert -bordercolor "#cccccc" -border 2 "$original" "$file"
