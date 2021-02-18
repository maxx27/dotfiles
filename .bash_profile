# include .bashrc if it exists
if [ -f "$HOME/.bashrc" ]; then
    . "$HOME/.bashrc"
fi

# set PATH so it includes user's private bin if it exists
for d in .local/bin .poetry/bin bin; do
    if [ -d "$HOME/$d" ] ; then
        PATH="$HOME/$d:$PATH"
    fi
done
export PATH

export LESS=iR

# DK
if [ -d "/opt/DK" ] ; then
    export DK_ROOT=/opt/DK
fi

if [ -f "~/.ssh/id_rsa" ]; then
    exec ssh-agent $BASH -s 10<&0 << "EOF"
        ssh-add ~/.ssh/id_rsa &> /dev/null
        exec $BASH <&10-
EOF
fi

if [[ ! $TERM =~ screen ]] && [ -z $TMUX ]; then
    if command -v tmux > /dev/null; then
        tmux attach || tmux new
    fi
fi
#if which tmux 1> /dev/null 2> /dev/null; then
#    case $HOSTNAME in
#        populus-*) USE_TMUX=1;;
#        *) USE_TMUX=0;;
#    esac
#    if [ $USE_TMUX -eq 1 ]; then
#        tmux attach || tmux new
#    fi
#fi

export RIPGREP_CONFIG_PATH=$HOME/.ripgreprc
