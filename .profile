# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

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

exec ssh-agent $BASH -s 10<&0 << EOF
    ssh-add ~/.ssh/id_rsa &> /dev/null
    exec $BASH <&10-
EOF

