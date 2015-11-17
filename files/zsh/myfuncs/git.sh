github-clone() {
    git clone git@github.com:"${1}".git "${@:2}"
}

remote-push () {
    br=$(git rev-parse --abbrev-ref HEAD)
    r="origin"
    if [ $# -gt 0 ];
    then
        r="$1"
    fi
    git push -u "$r" "$br"
}

merge-base-diff () {
    git diff "$(git merge-base HEAD "$1")"
}
