#!/bin/bash

LIST=$(cat <<EOF | perl -ne 'print "$1\n" if /^\s*(\S+)/'
    # jq
    # kubectx
    # kubernetes-cli
    # macfuse
    # node
    # ntfs-3g
    # reattach-to-user-namespace - using system clipboard
    # tmux                       - terminal multiplexor
    # xz
    # yq
    bash-completion            - autocomplete for bash
    # beyond-compare
    fzf
    git                        - VCS
    python                     - python programming language
    ranger                     - text file browser
    readline
    ripgrep
    vim
    youtube-dl
    yt-dlp
EOF
)

LIST_CASKS=$(cat <<EOF | perl -ne 'print "$1\n" if /^\s*(\S+)/'
    # affinity-designer
    # alt-tab
    # beyond-compare
    # curseforge
    # vlc
    affinity-designer
    affinity-photo
    daisydisk - Disk space visualizer
    docker
    flux
    font-inconsolata-lgc-nerd-font
    google-chrome
    iina                      - video player
    lastpass
    musescore
    obs
    obsidian
    paragon-ntfs
    parallels
    reaper
    scroll-reverser
    steam
    telegram
    transmission
    visual-studio-code
    whatsapp
    zenmate-vpn
    zoom
EOF
)

for PACKAGE in $LIST; do
    brew install $PACKAGE
done

for PACKAGE in $LIST_CASKS; do
    brew install -- cask $PACKAGE
done
