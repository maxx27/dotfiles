#!/bin/bash -e
# du_sort
# du_sort path1 path2 | head -n 5

# This gives you:
# - Size of hidden files/directories
# - Size of non-hidden files/directories
# - Grand total size of the current directory
find $@ -maxdepth 1 -type d -exec du -shx {} \; | sort -hr
