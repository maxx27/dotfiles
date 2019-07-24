#!/bin/bash

# awk '{print $1;}'

LIST=$(cat <<EOF | perl -ne 'print "$1\n" if /^\s*(\S+)/'
    htop       - performance monitor
    mc         - file manager
    terminator - pane terminal
    gparted    - disk partition manager
EOF
)

# remove unused fonts
LIST=$(cat <<EOF | perl -ne 'print "$1\n" if /^\s*(\S+)/'
    fonts-guru*
    fonts-kacst*
    fonts-khmeros-core
    fonts-lao
    fonts-lklug-sinhala
    fonts-lohit-*
    fonts-nanum
    fonts-noto-*
    fonts-sil-*
    fonts-takao-pgothic
    fonts-tibetan-machine
    fonts-tlwg-*
    fonts-navilu
    fonts-samyak-*
EOF
)
sudo apt remove -y $LIST

# update font cache
sudo fc-cache -fv
