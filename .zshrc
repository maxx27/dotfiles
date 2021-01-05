# See http://zsh.sourceforge.net/Doc/Release/Parameters.html

# Keypad
# 0 . Enter
bindkey -s "^[Op" "0"
bindkey -s "^[Ol" "."
bindkey -s "^[OM" "^M"
# 1 2 3
bindkey -s "^[Oq" "1"
bindkey -s "^[Or" "2"
bindkey -s "^[Os" "3"
# 4 5 6
bindkey -s "^[Ot" "4"
bindkey -s "^[Ou" "5"
bindkey -s "^[Ov" "6"
# 7 8 9
bindkey -s "^[Ow" "7"
bindkey -s "^[Ox" "8"
bindkey -s "^[Oy" "9"
# + -  * /
bindkey -s "^[Ok" "+"
bindkey -s "^[Om" "-"
bindkey -s "^[Oj" "*"
bindkey -s "^[Oo" "/"

# History
HISTFILE=~/.cache/zsh/history
HISTSIZE=1000
SAVEHIST=1000

# User configuration
setopt extendedglob nomatch
bindkey -e

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"


# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# autocompletion
#zstyle :compinstall filename '/c/Users/suslo/.zshrc'
autoload -Uz compinit
compinit -d ~/.cache/zsh/compdump

if [[ "$OSTYPE" =~ ^(msys|cygwin)$ ]]; then
    # Drives that cannot be reached by globbing.
    local drives=($(mount | command grep --perl-regexp '^\w: on /\w ' | cut --delimiter=' ' --fields=3))
    zstyle ':completion:*' fake-files "/:${(j. .)drives//\//}"

    # Use kill completion for wkill.
    compdef wkill=kill
    zstyle ':completion:*:*:wkill:*:processes' command "ps --user "$USER" --windows"
fi

# oh-my-zsh settings
[ -e $HOME/.zshmyrc ] && source $HOME/.zshmyrc
