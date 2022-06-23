#!/bin/bash -ex

if [[ $OSTYPE =~ msys ]]; then
    # see https://packages.msys2.org/package/zsh?repo=msys&variant=x86_64
    curl -LO https://repo.msys2.org/msys/x86_64/zsh-5.8-5-x86_64.pkg.tar.zst
    zstd -d zsh-5.8-5-x86_64.pkg.tar.zst
    sudo tar xf zsh-5.8-5-x86_64.pkg.tar -C /
    sudo rm /.BUILDINFO /.INSTALL /.MTREE /.PKGINFO
    rm zsh-5.8-5-x86_64.pkg.tar*
fi

if ! command -v zsh >/dev/null; then
    echo 'Please install zsh before'
    exit 1
fi

ZSH=~/.oh-my-zsh

# Prevent the cloned repository from having insecure permissions. Failing to do
# so causes compinit() calls to fail with "command not found: compdef" errors
# for users with insecure umasks (e.g., "002", allowing group writability). Note
# that this will be ignored under Cygwin by default, as Windows ACLs take
# precedence over umasks except for filesystems mounted with option "noacl".
umask g-w,o-w

if [ -e $ZSH ]; then
    pushd $ZSH
    git fetch origin
    git checkout origin/master
    popd
else
    git clone \
        -c core.eol=lf -c core.autocrlf=false \
        -c fsck.zeroPaddedFilemode=ignore \
        -c fetch.fsck.zeroPaddedFilemode=ignore \
        -c receive.fsck.zeroPaddedFilemode=ignore \
        --depth=1 https://github.com/robbyrussell/oh-my-zsh.git $ZSH
fi

if [ -e $ZSH/plugins/zsh-autosuggestions ]; then
    pushd $ZSH/plugins/zsh-autosuggestions
    git fetch origin
    git checkout origin/master
    popd
else
    git clone --depth=1 https://github.com/zsh-users/zsh-autosuggestions $ZSH/plugins/zsh-autosuggestions
fi

if [ -e $ZSH/plugins/zsh-syntax-highlighting ]; then
    pushd $ZSH/plugins/zsh-syntax-highlighting
    git fetch origin
    git checkout origin/master
    popd
else
    git clone --depth=1 https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH/plugins/zsh-syntax-highlighting
fi

if [ -e $ZSH/themes/powerlevel10k ]; then
    pushd $ZSH/themes/powerlevel10k
    git fetch origin
    git checkout origin/master
    popd
else
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $ZSH/themes/powerlevel10k
    echo "source $ZSH/themes/powerlevel10k/powerlevel10k.zsh-theme" > $ZSH/themes/powerlevel10k.zsh-theme
fi

if [ -e $ZSH/themes/spaceship-prompt ]; then
    pushd $ZSH/themes/spaceship-prompt
    git fetch origin
    git checkout origin/master
    popd
else
    git clone --depth=1 https://github.com/denysdovhan/spaceship-prompt.git $ZSH/themes/spaceship-prompt
    # it works on msys too than `ln -s`
    #ln -s ~/.oh-my-zsh/themes/spaceship-prompt/spaceship.zsh-theme ~/.oh-my-zsh/themes/spaceship.zsh-theme
    echo "source $ZSH/themes/spaceship-prompt/spaceship.zsh" > $ZSH/themes/spaceship.zsh-theme
fi

echo 'Execute the following command to change default shell'
echo 'chsh -s $(which zsh)'

mkdir -p ~/.cache/zsh

# Useful
# https://gist.github.com/tomma5o/302be3dc6e2092743e6049570e102a09
# https://gist.github.com/fworks/af4c896c9de47d827d4caa6fd7154b6b
#
