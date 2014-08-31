venv-activate() {
    source "$1"/bin/activate
}

forget-known-host () {
    ssh-keygen -f ~/.ssh/known_hosts -R "$1"
}

lgrep () {
    ls -lA | grep "$@"
}

source ~/.myfuncs/setup.sh
source ~/.myfuncs/aws.sh
source ~/.myfuncs/git.sh
source ~/.myfuncs/vmware.sh
