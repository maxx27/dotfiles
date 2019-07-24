#!/bin/bash

LIST=$(cat <<EOF | perl -ne 'print "$1\n" if /^\s*(\S+)/'
    ranger                     - text file browser
    git                        - VCS
    python                     - python programming language
    tmux                       - terminal multiplexor
    gradle                     - gradle for Java development
    reattach-to-user-namespace - using system clipboard
    bash-completion            - autocomplete for bash
EOF
)

for PACKAGE in $LIST; do
    brew install $PACKAGE
done
