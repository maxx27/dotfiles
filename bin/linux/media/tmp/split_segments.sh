#!/bin/bash -e

# Check if at least 2 arguments (input video and one timestamp) are provided
if [ "$#" -lt 2 ]; then
    echo "Usage: $0 <input_video> <timestamp1> [<timestamp2> ... <timestampN>]"
    exit 1
fi

# Input video file
input_video="$1"

# Remove the first argument (input video) from the list, leaving only timestamps
shift

# Directory to store the output segments
output_dir="segments"
mkdir -p "$output_dir"

# Helper function to convert time to seconds
time_to_seconds() {
    IFS=: read -r min sec <<< "$1"
    echo $((min * 60 + sec))
}

# Split the video based on timestamps
start_time=0
i=1
for timestamp in "$@"; do
    end_time=$(time_to_seconds "$timestamp")
    duration=$((end_time - start_time))

    # Extract the segment using ffmpeg
    output_file="${output_dir}/segment_${i}.mp4"
    ffmpeg -y -i "$input_video" -ss "$start_time" -t "$duration" -c copy "$output_file"

    # Move to the next segment
    start_time=$end_time
    ((i++))
done

# Handle the last segment (from the last timestamp to the end of the video)
output_file="${output_dir}/segment_${i}.mp4"
ffmpeg -y -i "$input_video" -ss "$start_time" -c copy "$output_file"

echo "Video split into segments successfully."
