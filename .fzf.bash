# Setup fzf
# ---------
if [[ ! "$PATH" == */d/Users/suslo/.fzf/bin* ]]; then
  export PATH="$PATH:/d/Users/suslo/.fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/d/Users/suslo/.fzf/shell/completion.bash" 2> /dev/null

# Key bindings
# ------------
source "/d/Users/suslo/.fzf/shell/key-bindings.bash"

