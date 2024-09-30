#!/bin/bash -e

# Check if at least 2 arguments (input video and one timestamp) are provided
if [ "$#" -lt 2 ]; then
    echo "Usage: $0 <input_file> <timestamp1> [<timestamp2> ... <timestampN>]"
    exit 1
fi

# Input video file
input_file="$1"
# Remove the first argument (input video) from the list, leaving only timestamps
shift

# Directory to store the output segments
output_dir=$(dirname "${input_file}")
filename=$(basename "${input_file}")
noext=${filename%.*}
ext=${filename##*.}

# Split the video based on timestamps
start_time=0
for timestamp in "$@"; do
    end_time=$timestamp

    # Prepare filename
    suffix=${start_time//[:]/_}
    output_file="${output_dir}/${noext}_${suffix}.${ext}"
    echo $output_file

    # Extract the segment using ffmpeg
    ffmpeg -y -i "$input_file" -ss "$start_time" -to "$end_time" -c copy "$output_file"

    # Move to the next segment
    start_time=$end_time
done

# Handle the last segment (from the last timestamp to the end of the video)
suffix=${start_time//[:]/_}
output_file="${output_dir}/${noext}_${suffix}.${ext}"
echo $output_file
ffmpeg -y -i "$input_file" -ss "$start_time" -c copy "$output_file"

echo "Video split into segments successfully."
