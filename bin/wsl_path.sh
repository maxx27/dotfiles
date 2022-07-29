#!/bin/bash -e

# bash is important. For /bin/sh:
# $ wsl_path.sh 'C:\Windows\System32\calc.exe'
# C:\Windows\System32
# last part got lost (don't know why, but suspect \c)

# Helper script to convert Windows path into WSL ones:
# $ wsl_path.sh 'C:\my\path'
# /mnt/c/my/path

echo "$1" | sed -E 's|\\|/|g' | sed -E 's|^([a-zA-Z]):/|/mnt/\l\1/|'
