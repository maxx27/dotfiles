#!/bin/bash -ex

LIST=$(cat <<EOF | grep -v -E -e '^[[:space:]]*#' | awk '{print $1;}'
    python3
    python3-pip
    python-is-python3
    ripgrep             - search files
    mc
    npm
    vim
    git
    zsh
    tmux
    tree
    htop
    dos2unix
    # ranger
EOF
)

sudo apt install -y $LIST
