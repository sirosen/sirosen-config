fix-vmware-modules () {
    sudo vmware-modconfig --console --install-all
}

vmware-cli-launch () {
    vmplayer ~/vmware/vmlib/"$1"/"$1".vmx &>/dev/null &
    disown
}

pearl-launch () {
    vmware-cli-launch pearl
}

mud-launch () {
    vmware-cli-launch mud
}

platinum-launch () {
    vmware-cli-launch platinum
}

midnight-launch () {
    vmware-cli-launch midnight
}

slate-launch () {
    vmware-cli-launch slate
}
