# usage:
#   . <path to file>
#   git_date "2035-03-06 18:00:00" commit -m "Sync changes"
function git_date() {
    local date=$1
    shift 1
    cmd="GIT_AUTHOR_DATE='$date' GIT_COMMITTER_DATE='$date' git "
    for arg in "$@"; do
        escaped=$(printf '%q\n' "$arg")
        cmd="$cmd $escaped"
    done
    eval $cmd
}