function globus-deploy () {
    ~/.globus-tools/go-ops/scripts/deploy/nexus-ux/deploy.sh "$@"
}

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

function production-adminpy () {
    globusenv-production
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

    echo "Personal AWS Account Environment"
    export GLOBUS_ENV="Personal"
    source ~/.globus-tools/globus-env-personal.sh
    venv-activate ~/.globus-tools/adminpy-venv
}

function globusenv-production () {
    globusenv-clear

    echo "Production AWS Account Environment"
    export GLOBUS_ENV="Production"
    source ~/.globus-tools/globus-env-production.sh
    venv-activate ~/.globus-tools/adminpy-venv
}
