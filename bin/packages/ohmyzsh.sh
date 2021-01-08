#!/bin/bash -ex

if ! command -v zsh >dev/null; then
    echo 'Please install zsh before'
    exit 1
fi

if [ $OSTYPE =~ msys ]; then
    # see https://packages.msys2.org/package/zsh?repo=msys&variant=x86_64
    curl -LO https://repo.msys2.org/msys/x86_64/zsh-5.8-3-x86_64.pkg.tar.xz
    sudo tar xf zsh-5.8-3-x86_64.pkg.tar.xz -C /
    sudo rm /.BUILDINFO /.INSTALL /.MTREE /.PKGINFO
    rm zsh-5.8-3-x86_64.pkg.tar.xz
fi

ZSH=~/.oh-my-zsh

# Prevent the cloned repository from having insecure permissions. Failing to do
# so causes compinit() calls to fail with "command not found: compdef" errors
# for users with insecure umasks (e.g., "002", allowing group writability). Note
# that this will be ignored under Cygwin by default, as Windows ACLs take
# precedence over umasks except for filesystems mounted with option "noacl".
umask g-w,o-w

git clone \
    -c core.eol=lf -c core.autocrlf=false \
    -c fsck.zeroPaddedFilemode=ignore \
    -c fetch.fsck.zeroPaddedFilemode=ignore \
    -c receive.fsck.zeroPaddedFilemode=ignore \
    --depth=1 https://github.com/robbyrussell/oh-my-zsh.git $ZSH
git clone --depth=1 https://github.com/zsh-users/zsh-autosuggestions $ZSH/plugins/zsh-autosuggestions
git clone --depth=1 https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH/plugins/zsh-syntax-highlighting

git clone --depth=1 https://github.com/denysdovhan/spaceship-prompt.git $ZSH/themes/spaceship-prompt
# it works on msys too than `ln -s`
#ln -s ~/.oh-my-zsh/themes/spaceship-prompt/spaceship.zsh-theme ~/.oh-my-zsh/themes/spaceship.zsh-theme
echo "source $ZSH/themes/spaceship-prompt/spaceship.zsh" > $ZSH/themes/spaceship.zsh-theme

echo 'Execute the following command to change default shell'
echo 'chsh -s $(which zsh)'

# Useful
# https://gist.github.com/tomma5o/302be3dc6e2092743e6049570e102a09
# https://gist.github.com/fworks/af4c896c9de47d827d4caa6fd7154b6b
#
