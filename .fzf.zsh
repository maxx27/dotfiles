# Setup fzf
# ---------
if [[ ! "$PATH" == *~/.github/fzf/bin* ]]; then
  export PATH="${PATH}:~/.github/fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source ~/.github/fzf/shell/completion.zsh 2> /dev/null

# Key bindings
# ------------
source ~/.github/fzf/shell/key-bindings.zsh
