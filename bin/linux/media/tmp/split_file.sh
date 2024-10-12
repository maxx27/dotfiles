#!/bin/bash -e

# Check if video file and timestamps file are provided
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <input_video> <timestamps_file>"
    exit 1
fi

# Input video file
input_video="$1"

# Timestamps file (format: minutes:seconds on each line)
timestamps_file="$2"

# Directory to store the output segments
output_dir="segments"
mkdir -p "$output_dir"

# Helper function to convert time to seconds
time_to_seconds() {
    IFS=: read -r min sec <<< "$1"
    echo $((min * 60 + sec))
}

# Read all timestamps into an array
timestamps=()
while IFS= read -r line; do
    timestamps+=("$line")
done < "$timestamps_file"

# Split the video based on timestamps
start_time=0
for i in "${!timestamps[@]}"; do
    end_time=$(time_to_seconds "${timestamps[$i]}")
    duration=$((end_time - start_time))

    # Extract the segment using ffmpeg
    output_file="${output_dir}/segment_$((i+1)).mp4"
    ffmpeg -y -i "$input_video" -ss "$start_time" -t "$duration" -c copy "$output_file"

    # Move to the next segment
    start_time=$end_time
done

# Handle the last segment (from the last timestamp to the end of the video)
output_file="${output_dir}/segment_$((i+2)).mp4"
ffmpeg -y -i "$input_video" -ss "$start_time" -c copy "$output_file"

echo "Video split into segments successfully."
