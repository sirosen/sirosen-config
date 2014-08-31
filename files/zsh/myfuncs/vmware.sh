fix-vmware-modules () {
    sudo vmware-modconfig --console --install-all
}

vmware-cli-launch () {
    vmplayer ~/vmware/vmlib/"$1"/"$1".vmx &>/dev/null &
    disown
}

ivory-launch () {
    vmware-cli-launch ivory
}

midnight-launch () {
    vmware-cli-launch midnight
}

slate-launch () {
    vmware-cli-launch slate
}
