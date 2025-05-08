#!/bin/bash -e

# Add frame to the image.
# It creates a backup image (in the same directory) with suffin "...-original" in the filename (it doesn't contain frame).

# https://askubuntu.com/questions/819482/how-to-add-a-border-using-imagemagick/1480001#1480001
if [ -z "$1" ]; then
    echo "Usage: $(basename $0) <image1> <image2> ..."
    exit 1
fi

for file in "${@}"; do
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

    # required ImageMagick v7
    magick "$original" -bordercolor "#cccccc" -border 2 "$file"
done
