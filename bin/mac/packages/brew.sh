#!/bin/bash

LIST=$(cat <<EOF | perl -ne 'print "$1\n" if /^\s*(\S+)/'

    # System
    duti                         - set app associations
    --cask --no-quarantine syntax-highlight      - more preview formats
    --cask --no-quarantine qlmarkdown
    # --cask glance-chamburr       - more preview formats (syntax-highlight лучше чем это)
    --cask cheatsheet            - show cheet sheet
    --cask flux
    --cask hiddenbar             - show less icons in the menu bar
    --cask logitech-options
    --cask obs
    --cask paragon-ntfs
    --cask scroll-reverser       - reverse direction for mouse only
    --cask alt-tab
    # ntfs-3g

    # Terminal
    --cask iterm2                - terminal replacement
    tmux                         - terminal multiplexor
    bash-completion              - autocomplete for bash
    fzf
    jq
    noahgorstein/tap/jqp         - playground TUI for jq
    ncdu
    ranger                       - text file browser
    readline
    rename                       - Perl-powered file rename script with many helpful built-ins
    ripgrep
    tree
    vim
    wget
    # xz

    # Development
    git
    plantuml
    pre-commit                   - hook usage for project validations
    python                       - python programming language
    --cask beyond-compare
    --cask fork                  - Git UI
    --cask visual-studio-code
    # node

    # ???
    --cask drawio
    --cask foxitreader           - (requires VPN)
    --cask google-chrome
    --cask keka                  - file archiver
    --cask lastpass
    --cask nimble-commander      - Two-pane file manager
    --cask obsidian
    --cask parallels
    --cask transmission
    --cask yandex-music-unofficial
    --cask zoom
    # --cask affinity-designer
    # --cask affinity-photo

    # Music
    --cask musescore
    --cask reaper

    # Multimedia
    ffmpeg
    # youtube-dl # looks outdated, use yt-dlp
    yt-dlp
    --cask iina                  - video player
    --cask vlc
    imagemagick

    # Infrastructure
    ansible
    --cask vagrant

    # Docker
    # --cask docker
    podman
    podman-compose
    # --cask podman-desktop
    lazydocker

    # Kubernetes
    kubernetes-cli
    k9s
    --cask openlens
    kubectx
    minikube
    # kind - не понравился, minikube лучше
    helm

    # Messagers
    --cask telegram
    --cask whatsapp

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
    --cask --no-quarantine prismlauncher
EOF
)

for PACKAGE in $LIST; do
    brew install $PACKAGE
done
