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
    # --cask logitech-options    - deprecated, logitech options plus isn't available in brew; download it manually
    --cask obs
    --cask paragon-ntfs
    --cask scroll-reverser       - reverse direction for mouse only
    --cask alt-tab
    # ntfs-3g
    fio                          - disk speed test

    # Terminal
    --cask iterm2                - terminal replacement
    tmux                         - terminal multiplexor
    bash-completion              - autocomplete for bash
    fzf
    jq
    # Choose one yq:
    # yq                           - https://github.com/mikefarah/yq
    python-yq                    - https://github.com/kislyuk/yq
    noahgorstein/tap/jqp         - playground TUI for jq
    ncdu
    ranger                       - text file browser
    readline
    rename                       - Perl-powered file rename script with many helpful built-ins
    ripgrep
    rsync
    tree
    vim
    wget
    # xz
    # GNU utils - more at https://github.com/darksonic37/linuxify/blob/master/linuxify
    coreutils
    binutils
    diffutils
    findutils
    gnu-sed
    grep

    # Development
    git
    pre-commit                   - hook usage for project validations
    python                       - python programming language
    --cask beyond-compare
    --cask fork                  - Git UI
    --cask visual-studio-code
    # node
    --cask processing
    openjdk@17
    --cask intellij-idea-ce
    go
    adr-tools
    structurizr-cli              - C4 Model
    --cask drawio
    plantuml
    pandoc

    # Infrastructure
    ansible
    --cask vagrant
    brew tap hashicorp/tap
    brew install hashicorp/tap/vault

    # Docker
    --cask docker
    # podman
    # podman-compose
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

    # ???
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

    # Messagers
    --cask telegram
    --cask whatsapp

    # Office
    --cask xmind

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
    --cask --no-quarantine prismlauncher

    # Game Development
    --cask godot
EOF
)

for PACKAGE in $LIST; do
    brew install $PACKAGE
done
