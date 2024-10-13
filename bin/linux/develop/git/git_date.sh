# usage:
#   $ source <path to this file>/git_date.sh
#   $ git_date "2035-03-06 18:00:00" commit -m "Sync changes"
function git_date() {
    local date=$1
    shift 1
    # local author='
    # GIT_AUTHOR_NAME="John Doe"
    # GIT_AUTHOR_EMAIL="jdoe@example.net"
    # GIT_COMMITTER_NAME="John Doe"
    # GIT_COMMITTER_EMAIL="jdoe@example.net"
    # '
    cmd="$author GIT_AUTHOR_DATE='$date' GIT_COMMITTER_DATE='$date' git "
    for arg in "$@"; do
        escaped=$(printf '%q\n' "$arg")
        cmd="$cmd $escaped"
    done
    eval $cmd
}
