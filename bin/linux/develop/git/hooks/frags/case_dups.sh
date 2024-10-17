#!/bin/sh -e

# From https://stackoverflow.com/questions/41154015/how-to-prevent-git-from-committing-two-files-with-names-differing-only-in-case
# Hooks: pre-commit
# Stop if duplicate names in different cases are found

TF=$(mktemp)
trap "rm -f $TF" 0 1 2 3 15
checkstdin() {
    sort -f | uniq -di > $TF
    test -s $TF || return 0   # if $TF is empty, we are good
    echo "non-unique (after case folding) names found!" 1>&2
    cat $TF 1>&2
    return 1
}

git ls-files | checkstdin || {
    echo "ERROR - file name collision, stopping commit" 1>&2
    exit 1
}
