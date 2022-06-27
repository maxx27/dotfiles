
# See http://zsh.sourceforge.net/Doc/Release/Parameters.html

# Update PATH
export -U PATH=/mingw64/bin${PATH:+:$PATH}
export -U PATH=/bin${PATH:+:$PATH}
export -U PATH=/usr/bin${PATH:+:$PATH}
export -U PATH=/usr/local/bin${PATH:+:$PATH}
export -U PATH=~/bin${PATH:+:$PATH}

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

# set emacs style
bindkey -e

# History
mkdir -p ~/.cache/zsh
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

# You may need to manually set your language environment
export LANG=en_US.UTF-8



# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi


# export MANPATH="/usr/local/man:$MANPATH"

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
    kubectl() {
        unfunction "$0"
        source <(kubectl completion zsh)
        alias k=kubectl
        complete -F __start_kubectl k
        $0 "$@"
    }
fi

if command -v kustomize >/dev/null; then
    kustomize() {
        unfunction "$0"
        source <(kustomize completion zsh)
        $0 "$@"
    }
fi

if command -v minikube >/dev/null; then
    minikube() {
        unfunction "$0"
        source <(minikube completion zsh)
        $0 "$@"
    }
fi

if command -v helm >/dev/null; then
    helm() {
        unfunction "$0"
        source <(helm completion zsh)
        $0 "$@"
    }
fi

if command -v aws >/dev/null; then
    aws() {
        unfunction "$0"
        complete -C aws_completer aws
        $0 "$@"
    }
fi

if command -v ~/yandex-cloud/bin/yc >/dev/null; then
    yc() {
        unfunction "$0"
        export PATH=~/yandex-cloud:${PATH}
        test -e ~/yandex-cloud/completion.zsh.inc && source ~/yandex-cloud/completion.zsh.inc
        $0 "$@"
    }
fi

autoload -U +X bashcompinit && bashcompinit
if command -v terraform >/dev/null; then
    terraform() {
        unfunction "$0"
        complete -o nospace -C terraform terraform
        $0 "$@"
    }
fi


# if [[ -e ~/.github/fzf-tab-completion ]]; then
#     source ~/.github/fzf-tab-completion/zsh/fzf-zsh-completion.sh
#     bindkey '^I' fzf_completion
# fi
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh


if [[ -e ~/.zshmyrc && -e ~/.oh-my-zsh ]]; then
    # oh-my-zsh settings
    source ~/.zshmyrc
else
    # source ~/.oh-my-zsh/plugins/zsh-autosuggestions
    # source ~/.oh-my-zsh/plugins/zsh-syntax-highlighting
fi
