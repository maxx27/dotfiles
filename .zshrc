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

# Options
# See https://linux.die.net/man/1/zshoptions
setopt correct
setopt extendedglob
setopt nomatch
unsetopt autocd
unsetopt autopushd

# set emacs style
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


# Update PATH
export -U PATH=~/bin${PATH:+:$PATH}
export -U PATH=/usr/local/bin${PATH:+:$PATH}

# autocompletion
#zstyle :compinstall filename ~/.zshrc
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


# host specific settings

case $(hostname) in
    Maxx-Air)
        export PATH="/Applications/Visual Studio Code.app/Contents/Resources/app/bin:$PATH"
        export PATH="/usr/local/Cellar/openjdk/15.0.1/bin:$PATH"
esac

if command -v kubectl >/dev/null; then
    source <(kubectl completion zsh)
    alias k=kubectl
    complete -F __start_kubectl k
fi

if command -v kustomize >/dev/null; then
    source <(kustomize completion zsh)
fi

if command -v minikube >/dev/null; then
    source <(minikube completion zsh)
fi

if command -v helm >/dev/null; then
    source <(helm completion zsh)
fi

if [[ -e ~/.zshmyrc && -e ~/.oh-my-zsh ]]; then
    # oh-my-zsh settings
    source ~/.zshmyrc
else
    source ~/.oh-my-zsh/plugins/zsh-autosuggestions
    source ~/.oh-my-zsh/plugins/zsh-syntax-highlighting
fi
