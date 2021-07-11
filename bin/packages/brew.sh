#!/bin/bash

LIST=$(cat <<EOF | perl -ne 'print "$1\n" if /^\s*(\S+)/'
    ranger                     - text file browser
    git                        - VCS
    python                     - python programming language
    tmux                       - terminal multiplexor
    reattach-to-user-namespace - using system clipboard
    bash-completion            - autocomplete for bash
    awscli
    jq
    kubectx
    kubernetes-cli
    lf
    node
    ntfs-3g
    oniguruma
    openjdk
    python
    readline
    ripgrep
    vim
    xz
    youtube-dl
    yq
    alt-tab
    discord
    docker
    google-chrome
    google-cloud-sdk
    iina                      - video player
    lastpass
    microsoft-teams
    obs
    osxfuse
    pycharm-ce
    telegram
    transmission
    vlc
    zoom
EOF
)

for PACKAGE in $LIST; do
    brew install $PACKAGE
done

# TODO: make separate list or flag?
# brew install --cask google-chrome
# brew install --cask docker
