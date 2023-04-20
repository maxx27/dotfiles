
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

ZSH_THEME=powerlevel10k/powerlevel10k # spaceship, powerlevel10k/powerlevel10k, af-magic

if [[ $ZSH_THEME == "powerlevel10k/powerlevel10k" ]]; then
    # Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
    # Initialization code that may require console input (password prompts, [y/n]
    # confirmations, etc.) must go above this block; everything else may go below.
    if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
        source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
    fi
fi


# export MANPATH="/usr/local/man:$MANPATH"

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
    export EDITOR='vim'
else
    export EDITOR='code -w'
fi

source ~/.zsh/aliases
source ~/.zsh/autocompletions

if [[ -e ~/.zsh/.zshmyrc && -e ~/.github/.oh-my-zsh ]]; then
    # oh-my-zsh settings
    source ~/.zsh/.zshmyrc
else
    # source ~/.github/.oh-my-zsh/plugins/zsh-autosuggestions
    # source ~/.github/.oh-my-zsh/plugins/zsh-syntax-highlighting
fi

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
