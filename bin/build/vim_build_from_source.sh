#!/bin/bash
set -x -e

# Steps to build and install tmux from source on Ubuntu.
VERSION=8.1.0438-1
# PACKAGES='vim vim-common vim-runtime vim-tiny vim-tiny vim-gtk3 neovim vim-athena vim-nox vim-gtk'
# sudo apt-get -y remove $PACKAGES || sudo dpkg -r $PACKAGES || true
# sudo apt-get -y install git libncurses5-dev \
#     python-dev python3-dev ruby-dev lua5.1 liblua5.1-dev libperl-dev \
#     ibxpm-dev libxt-dev gnome-devel libx11-dev \
#     # ?? libcairo2-dev libgnome2-dev libgnomeui-dev libgtk2.0-dev libatk1.0-dev libbonoboui2-dev \

# git clone git@github.com:vim/vim.git

# You can find a description of features in https://github.com/vim/vim/blob/master/src/Makefile
#
sudo git clean -dfx
./configure --with-features=huge \
        --enable-fail-if-missing \
        --enable-multibyte \
        --enable-gui=auto \
        --enable-rubyinterp \
        --enable-pythoninterp \
        --with-python-command=python2.7 \
        --enable-python3interp \
        --with-python3-command=python3.6 \
        --enable-perlinterp \
        --enable-luainterp \
        --enable-cscope \
        --disable-netbeans \
        --disable-arabic \
        --disable-farsi \
        --prefix=/usr/local
make VIMRUNTIMEDIR=/usr/local/share/vim/vim81 -j4
make test
# [ -e tmux-${VERSION} ] && sudo rm -rf tmux-${VERSION}
# tar xf tmux-${VERSION}.tar.gz
# rm -f tmux-${VERSION}.tar.gz
# cd tmux-${VERSION}
# ./configure --prefix=/usr/local
# make -j $(nproc)
sudo checkinstall -y --pkgname vim --pkgversion ${VERSION}
sudo ln -s /usr/local/bin/vim /usr/bin/vi

# # cd -
# sudo rm -rf /usr/local/src/tmux-*
# sudo mv tmux-${VERSION} /usr/local/src

# Logout and login to the shell again and run.
# [ "$TMUX" == "" ] && tmux -V
