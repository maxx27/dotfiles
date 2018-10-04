# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

if [[ ! $TERM =~ screen ]] && [ -z $TMUX ]; then
    export TERM=xterm-256color
fi
case $HOSTNAME in
    beta|MSuslov)
        # set terminal type, if you have installed Dwimperl
        # http://stackoverflow.com/questions/11219266/how-to-fix-warning-terminal-is-not-fully-functional-error-in-command-console
        # export TERM=msys
        # export TERM=xterm
        export TERM='cygwin'
    ;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
# screen is set by tmux
case "$TERM" in
    xterm-color|cygwin|screen|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
        # We have color support; assume it's compliant with Ecma-48
        # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
        # a case would tend to support setf rather than setaf.)
        color_prompt=yes
    else
        color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
    # Custom bash prompt via kirsle.net/wizards/ps1.html
    # PS1="\[$(tput bold)\]\[$(tput setaf 4)\][\[$(tput setaf 5)\]\u\[$(tput setaf 4)\]@\[$(tput setaf 5)\]\h \[$(tput setaf 2)\]\W\[$(tput setaf 4)\]]\\$ \[$(tput sgr0)\]"
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac
# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'


# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

case $HOSTNAME in
    msuslov-lnx)
        # at Luxoft ESET issue
        export MAN_DISABLE_SECCOMP=1
        # at Luxoft https://stackoverflow.com/questions/27835619/urllib-and-ssl-certificate-verify-failed-error
        export PYTHONHTTPSVERIFY=0
    ;;
    beta)
        USER=msuslov
        PATH="/d/Users/suslo/perl5/bin${PATH:+:${PATH}}"; export PATH;
        PERL5LIB="/d/Users/suslo/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
        PERL_LOCAL_LIB_ROOT="/d/Users/suslo/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
        PERL_MB_OPT="--install_base \"/d/Users/suslo/perl5\""; export PERL_MB_OPT;
        PERL_MM_OPT="INSTALL_BASE=/d/Users/suslo/perl5"; export PERL_MM_OPT;
    ;;
esac

if [ -d /c/ProgramData/chocolatey/bin ]; then
    export PATH="$PATH:/c/ProgramData/chocolatey/bin"
fi
