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
    --cask google-chrome
    --cask lastpass
    --cask musescore
    --cask obs
    --cask paragon-ntfs
    --cask parallels
    --cask reaper
    --cask transmission
    --cask yandex-music-unofficial
    --cask zoom

    # System
    duti                         - set app associations
    --cask hiddenbar             - show less icons in the menu bar
    --cask flux
    # --cask alt-tab
    --cask scroll-reverser       - reverse direction for mouse only
    --cask keka                  - file archiver
    --cask logitech-options
    # --cask glance-chamburr       - more preview formats (syntax-highlight лучше чем это)
    --cask --no-quarantine syntax-highlight      - more preview formats

    # Terminal
    --cask iterm2                - terminal replacement
    tmux                         - terminal multiplexor
    bash-completion              - autocomplete for bash
    fzf
    jq
    ncdu
    ranger                       - text file browser
    readline
    rename                       - Perl-powered file rename script with many helpful built-ins
    ripgrep
    vim
    # xz

    # File Managers
    --cask nimble-commander
    --cask commander-one
    # --cask dcommander - payed

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
    git
    --cask gittyup               - не может быть проверен
    # glint?
    --cask fork
    --cask sourcetree
    # --cask gitkraken # платный
    # --cask gitfiend                     - git GUI не понравился

    # Office
    plantuml
    --cask obsidian
    --cask visual-studio-code
    --cask foxitreader                  - (requires VPN)

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
    helm

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
