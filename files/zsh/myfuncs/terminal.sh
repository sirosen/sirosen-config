solarized-terminal-setup () {
    cp "$HOME/.config/xfce4/terminal/$1" "$HOME/.config/xfce4/terminal/terminalrc"
}
solarized-light-terminal-setup () {
    solarized-terminal-setup light
}
solarized-dark-terminal-setup () {
    solarized-terminal-setup dark
}

set-terminal-font-size () {
    newsize="$1"
    current="$HOME/.config/xfce4/terminal/terminalrc"
    light="$HOME/.config/xfce4/terminal/light"
    dark="$HOME/.config/xfce4/terminal/dark"
    for f in $current $light $dark;
    do
        sedexpr='s/FontName.*/FontName=Monospace '$newsize'/g'
        sed -i "$sedexpr" "$f"
    done
}
