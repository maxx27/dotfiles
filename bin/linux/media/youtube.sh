#!/bin/bash
# Download youtube video with desired quality
# youtube-dl accepts both fully qualified URLs and video id's such as AQcQgfvfF1M
url="$*"
echo "Fetching available formats for $url..."
yt-dlp -F "$url"
read -p "Please enter the desired quality code: " FORMAT
yt-dlp -f $FORMAT -g "$url"
