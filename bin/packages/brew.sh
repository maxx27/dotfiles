#!/bin/bash

LIST=$(cat <<EOF | perl -ne 'print "$1\n" if /^\s*(\S+)/'
    font-inconsolata-lgc-nerd-font
    google-chrome
    lastpass
    alt-tab
    bash-completion            - autocomplete for bash
    youtube-dl
    ripgrep
    ranger                     - text file browser
    git                        - VCS
    # ntfs-3g
    readline
    vim
    # xz
    # tmux                       - terminal multiplexor
    telegram
    # transmission

    # development
    docker
    # JS
    node
    jq

    python                     - python programming language
    # pycharm-ce
    # reattach-to-user-namespace - using system clipboard
    # awscli
    # kubernetes-cli
    # kubectx
    # lf
    # yq

    # oniguruma
    # openjdk
    # discord
    # google-cloud-sdk
    iina                      - video player
    # microsoft-teams
    # zoom
    # obs
    # osxfuse
    # vlc
EOF
)

for PACKAGE in $LIST; do
    brew install $PACKAGE
done

# TODO: make separate list or flag?
# brew install --cask google-chrome
# brew install --cask docker
