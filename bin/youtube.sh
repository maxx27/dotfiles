#!/bin/bash
# Download youtube video with desired quality
# youtube-dl accepts both fully qualified URLs and video id's such as AQcQgfvfF1M
url="$*"
echo "Fetching available formats for $url..."
youtube-dl -F "$url"
read -p "Please enter the desired quality code: " FORMAT
youtube-dl -f $FORMAT -g "$url"
