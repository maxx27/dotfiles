
case $HOSTNAME in
    populus-*)
        alias sj='sudo -H -u jenkins'
    ;;
    msuslov-lnx)
        # NOTE: 'ln -s' doesn't work
    ;;
    MSuslov)
        alias subl='"/c/Program Files/Sublime Text 3/sublime_text.exe"'
        alias code='"/c/Program Files/Microsoft VS Code/Code.exe"'
        alias cdp='cd /d/Work/Populus/Repo/_Populus/Populus'
        alias cdl='cd /d/Work/Populus/Repo/_LSR/LSR'
        alias cdg='cd /d/Work/Populus/Repo/_LSR/9831_GWM_Aptiv_LSR'
    ;;
    beta)
        alias subl='/d/Programs/_Office/Sublime/sublime_text.exe'
        alias cdp='cd /d/Populus/Populus'
        alias cdpd='cd /d/Populus/PopulusDoc'
    ;;
esac

if command -v tmux >/dev/null; then
    alias ta='tmux attach'
    alias tls='tmux ls'
    alias tat='tmux attach -t'
    alias tns='tmux new-session -s'
    alias tso='tmux show-options'
fi

# FROM DEFAULT CONFIG

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

alias apt-all='sudo apt update && apt list --upgradable | less && sudo apt -y upgrade; sudo apt autoremove -y'
