#!/bin/bash

LIST=$(cat <<EOF | perl -ne 'print "$1\n" if /^\s*(\S+)/'
    # macfuse
    # node
    # ntfs-3g
    # reattach-to-user-namespace - using system clipboard
    python                       - python programming language
    --cask affinity-designer
    --cask affinity-photo
    --cask beyond-compare
    --cask drawio
    --cask foxitreader                  - (requires VPN)
    --cask google-chrome
    --cask lastpass
    --cask musescore
    --cask obs
    --cask obsidian
    --cask paragon-ntfs
    --cask parallels
    --cask reaper
    --cask transmission
    --cask visual-studio-code
    --cask yandex-music-unofficial
    --cask zoom

    # System
    duti                         - set app associations
    --cask hiddenbar                    - show less icons in the menu bar
    --cask flux
    # --cask alt-tab
    --cask scroll-reverser
    --cask keka                         - file archiver
    --cask logitech-options

    # Terminal
    tmux                         - terminal multiplexor
    --cask iterm2                - terminal replacement
    bash-completion              - autocomplete for bash
    jq
    fzf
    ranger                       - text file browser
    readline
    rename                       - Perl-powered file rename script with many helpful built-ins
    ripgrep
    vim
    # xz

    # Multimedia
    ffmpeg
    # youtube-dl # looks outdated, use yt-dlp
    yt-dlp
    --cask iina                         - video player
    --cask vlc

    # Infrastructure
    ansible
    --cask vagrant

    # Git
    git                          - VCS
    --cask gitfiend                     - git GUI


    # Messagers
    --cask telegram
    --cask whatsapp

    # Docker
    # --cask docker
    podman
    podman-compose
    --cask podman-desktop
    lazydocker

    # Kubernetes
    kubernetes-cli
    k9s
    --cask openlens
    kubectx
    minikube
    # kind - не понравился, minikube лучше

    # VPN
    # cyberghost-vpn - requires VPN to download !
    # zenmate-vpn

    # Fonts
    # more fonts names at https://gist.github.com/davidteren/898f2dcccd42d9f8680ec69a3a5d350e
    --cask font-inconsolata-lgc-nerd-font
    --cask font-dejavu-sans-mono-nerd-font
    --cask font-blex-mono-nerd-font

    # Games
    --cask steam
    --cask epic-games
    # --cask curseforge
EOF
)

for PACKAGE in $LIST; do
    brew install $PACKAGE
done
