function globus-clone () {
    github-clone globusonline/"$1" "${@:2}"
}

function gcp () {
    ~/dev/globus/testing/gcp/current/globusconnectpersonal "$@" -start &
    disown
}

function unmerged-signoff-tags () {
    git rev-list --all --not integration --format=%d | \
        grep -o "JIRA-[A-Z]*-[0-9]*-SIGNOFF-[0-9]*" | sort -u
}

function nexus-auth () {
    curl -v -H "Content-Type: application/json" --data \
        '{"username":"'"$1"'","password":"'"$2"'"}' \
        https://nexus.api.globusonline.org/authenticate
}

function deploy-scriptdir-cd () {
    cd ~/dev/globus/go-ops/products/nexus-and-web/deploy
}


# nagios access

function globus-transfer-nagios-tunnel () {
    ssh -N -L 8090:localhost:80 backdoor@xfer-nagios.globus &
}

function globus-transfer-nagios-tunnel-backup () {
    ssh -N -L 8090:localhost:80 backdoor@xfer-nagios-backup.globus &
}


# adminpy funcs

function adminpy () {
    globusenv-personal
    ~/.globus-tools/transfer-adminpy/admin.py "$@"
    globusenv-clear
}

function adminpy-transfer () {
    globusenv-transfer
    ~/.globus-tools/transfer-adminpy/admin.py "$@"
    globusenv-clear
}

function adminpy-nexus () {
    globusenv-nexus
    ~/.globus-tools/transfer-adminpy/admin.py "$@"
    globusenv-clear
}

function adminpy-demo () {
    globusenv-demo
    ~/.globus-tools/transfer-adminpy/admin.py "$@"
    globusenv-clear
}

function adminpy-genomics () {
    globusenv-genomics
    ~/.globus-tools/transfer-adminpy/admin.py "$@"
    globusenv-clear
}

function adminpy-genomics-dev () {
    globusenv-genomics-dev
    ~/.globus-tools/transfer-adminpy/admin.py "$@"
    globusenv-clear
}

function globusenv-clear() {
    if [ -n "$VIRTUAL_ENV" ];
    then
        deactivate
    fi

    if [ -n "$GLOBUS_ENV" ];
    then
        unset ADMIN_AWS_ACCT
        unset ADMIN_AWS_KEY
        unset ADMIN_AWS_SECRET
        unset ADMIN_AWS_KEYPAIR
        unset ADMIN_SSH_USER
        unset ADMIN_OSSEC_SERVER_USER
        unset AWS_CONFIG_FILE

        unset GLOBUS_ENV
    fi
}

function globusenv-personal() {
    globusenv-clear

    echo "Personal Account"
    export GLOBUS_ENV="Personal"
    source ~/.globus-tools/globus-env-personal.sh
    venv-activate ~/.globus-tools/adminpy-venv
}

function globusenv-nexus() {
    globusenv-clear

    echo "Nexus/UX Account"
    export GLOBUS_ENV="Nexus"
    source ~/.globus-tools/globus-env-nexus.sh
    venv-activate ~/.globus-tools/adminpy-venv
}

function globusenv-transfer() {
    globusenv-clear

    echo "Transfer Account"
    export GLOBUS_ENV="Production"
    source ~/.globus-tools/globus-env-transfer.sh
    venv-activate ~/.globus-tools/adminpy-venv

    local token_loc="/tmp/globus-mfa-token-$$"
    ~/.globus-tools/transfer-adminpy/mfa_token.py > "$token_loc"
    source "$token_loc"
    rm -f "$token_loc"
}

function globusenv-demo() {
    globusenv-clear

    echo "Demo Account"
    export GLOBUS_ENV="Demo"
    source ~/.globus-tools/globus-env-demo.sh
    venv-activate ~/.globus-tools/adminpy-venv
}

function globusenv-genomics() {
    globusenv-clear

    echo "Genomics Prod Account"
    export GLOBUS_ENV="Genomics"
    source ~/.globus-tools/globus-env-genomics.sh
    venv-activate ~/.globus-tools/adminpy-venv
}

function globusenv-genomics-dev() {
    globusenv-clear

    echo "Genomics Dev Account"
    export GLOBUS_ENV="GenomicsDev"
    source ~/.globus-tools/globus-env-genomics-dev.sh
    venv-activate ~/.globus-tools/adminpy-venv
}
