
sj_() {
    ls $@
}
alias sj=sj_

# some more aliases for Populus
case $HOSTNAME in
    populus-*)
        alias sj='sudo -H -u jenkins'
    ;;
    MSuslov)
       alias cdp='cd /d/Work/Populus/Repo/Populus'
       alias cdpd='cd /d/Work/Populus/Repo/PopulusDoc'
    ;;
esac

