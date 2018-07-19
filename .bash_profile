
# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
        . "$HOME/.bashrc"
    fi
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

#SCREEN_NAME=main
#screen -list $SCREEN_NAME -q
#if [ $? -ge 11 ] ; then
#    # if found then attach
#    screen -x $SCREEN_NAME
#else
#    # otherwise create new session
#    screen -S $SCREEN_NAME
#fi

case $HOSTNAME in
    populus-*) USE_TMUX=1;;
    *) USE_TMUX=0;;
esac
if [ $USE_TMUX -eq 1 ]; then
    tmux attach || tmux new
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
