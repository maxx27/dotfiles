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
    bash-completion              - autocomplete for bash
    duti                         - set app associations
    fzf
    git                          - VCS
    python                       - python programming language
    ranger                       - text file browser
    readline
    ripgrep
    vim
    youtube-dl
    yt-dlp
EOF
)

LIST_CASKS=$(cat <<EOF | perl -ne 'print "$1\n" if /^\s*(\S+)/'
    # alt-tab
    # beyond-compare
    # curseforge
    # vlc
    affinity-designer
    affinity-photo
    daisydisk                    - disk space visualizer
    docker
    flux
    foxitreader
    gitfiend                     - git GUI
    google-chrome
    hiddenbar                    - show less icons in the menu bar
    iina                         - video player
    lastpass
    logitech-options
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
    zoom

    # cyberghost-vpn - requires VPN to download !
    # zenmate-vpn
EOF
)

# more fonts names at
# https://gist.github.com/davidteren/898f2dcccd42d9f8680ec69a3a5d350e
LIST_FONTS=$(cat <<EOF | perl -ne 'print "$1\n" if /^\s*(\S+)/'
    font-inconsolata-lgc-nerd-font
    font-dejavu-sans-mono-nerd-font
    font-blex-mono-nerd-font
EOF
)

for PACKAGE in $LIST; do
    brew install $PACKAGE
done

for PACKAGE in $LIST_CASKS; do
    brew install --cask $PACKAGE
done

brew tap homebrew/cask-fonts
for PACKAGE in $LIST_FONTS; do
    brew install --cask $PACKAGE
done
