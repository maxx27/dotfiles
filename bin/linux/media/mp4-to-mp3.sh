#!/bin/bash -ex
find . -type f -name "*.mp4" -print0 | while IFS= read -r -d '' file; do
    basename=$(basename -s .mp4 "$file")
    echo "$basename"
    if [ ! -e "$basename.mp3" ]; then
        ffmpeg -i "$file" "$basename.mp3"
    fi
done

ls -lh *.mp3
