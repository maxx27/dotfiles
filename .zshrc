
# See http://zsh.sourceforge.net/Doc/Release/Parameters.html

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# Show all parameters
# set -o

# See https://linux.die.net/man/1/zshoptions
setopt correct
setopt extendedglob
setopt nomatch
unsetopt autocd
unsetopt autopushd
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

    # To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
    [[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh
fi

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
    export EDITOR='vim'
else
    export EDITOR='code -w'
fi

if [[ -e ~/.zsh/.zshmyrc && -e ~/.github/.oh-my-zsh ]]; then
    # oh-my-zsh settings
    source ~/.zsh/.zshmyrc
else
    # source ~/.github/.oh-my-zsh/plugins/zsh-autosuggestions
    # source ~/.github/.oh-my-zsh/plugins/zsh-syntax-highlighting
fi

source ~/.zsh/paths
source ~/.zsh/programs
source ~/.zsh/aliases
# oh-my-zsh resets history settings, thus they are after oh-my-zsh
source ~/.zsh/history

[ -f ~/.iterm2_shell_integration.zsh ] && source ~/.iterm2_shell_integration.zsh
