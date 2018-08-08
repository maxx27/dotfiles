# include .bashrc if it exists
if [ -f "$HOME/.bashrc" ]; then
    . "$HOME/.bashrc"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

if [ -d "/opt/DK" ] ; then
    export DK_ROOT=/opt/DK
fi

if [ -f "~/.ssh/id_rsa" ]; then
    exec ssh-agent $BASH -s 10<&0 << "EOF"
        ssh-add ~/.ssh/id_rsa &> /dev/null
        exec $BASH <&10-
EOF
fi

# set some specific folder as default folder instead of home (starting) one
# if [ "$(pwd)" == "$HOME" ]; then
#     declare -a dirs=("/d/Populus/Populus" "/c/src/SWIFT_int")
#     for i in "${dirs[@]}"
#     do
#         if [ -d "$i" ]; then
#             cd "$i"
#         fi
#     done
# fi

if command -v tmux > /dev/null; then
    if [[ ! $TERM =~ screen ]] && [ -z $TMUX ]; then
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
