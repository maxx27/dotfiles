
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

exec ssh-agent $BASH -s 10<&0 << EOF
    ssh-add ~/.ssh/id_rsa &> /dev/null
    exec $BASH <&10-
EOF

