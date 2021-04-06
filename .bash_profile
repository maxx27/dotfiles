# include .bashrc if it exists
if [ -f "$HOME/.bashrc" ]; then
    . "$HOME/.bashrc"
fi

# if [ -f "~/.ssh/id_rsa" ]; then
#     exec ssh-agent $BASH -s 10<&0 << "EOF"
#         ssh-add ~/.ssh/id_rsa &> /dev/null
#         exec $BASH <&10-
# EOF
# fi

if [[ ! $TERM =~ screen ]] && [ -z $TMUX ]; then
    if command -v tmux > /dev/null; then
        tmux attach || tmux new
    fi
fi
