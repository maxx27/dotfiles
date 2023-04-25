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

    ansible
    --cask vagrant

    # --cask alt-tab
    # --cask curseforge
    # --cask vlc

    --cask affinity-designer
    --cask affinity-photo
    --cask beyond-compare
    --cask daisydisk                    - disk space visualizer
    --cask drawio
    --cask flux
    --cask foxitreader
    --cask gitfiend                     - git GUI
    --cask google-chrome
    --cask hiddenbar                    - show less icons in the menu bar
    --cask iina                         - video player
    --cask lastpass
    --cask logitech-options
    --cask musescore
    --cask obs
    --cask obsidian
    --cask paragon-ntfs
    --cask parallels
    --cask reaper
    --cask scroll-reverser
    --cask steam
    --cask telegram
    --cask transmission
    --cask visual-studio-code
    --cask vlc
    --cask yandex-music-unofficial
    --cask whatsapp
    --cask zoom

    # Docker
    # --cask docker
    podman
    podman-compose
    --cask podman-desktop
    lazydocker

    # Kubernetesß
    k9s
    kubernetes-cli

    # VPN
    # cyberghost-vpn - requires VPN to download !
    # zenmate-vpn

    # Fonts
    # more fonts names at https://gist.github.com/davidteren/898f2dcccd42d9f8680ec69a3a5d350e
    --cask font-inconsolata-lgc-nerd-font
    --cask font-dejavu-sans-mono-nerd-font
    --cask font-blex-mono-nerd-font
EOF
)

for PACKAGE in $LIST; do
    brew install $PACKAGE
done
