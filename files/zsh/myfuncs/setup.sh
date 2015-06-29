vundle-setup () {
    git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle 2&>/dev/null
    (cd ~/.vim/bundle/vundle && git pull 2&>1 >/dev/null)
    vim +PluginInstall +qall
}

magick-hostname-background-gnome3 () {
    local image_loc="$HOME/Pictures/autogenbg.png"
    convert -size 1440x900 xc:lightgrey -font Palatino-Bold -pointsize 128 -fill black -draw "text 400,300 '$(hostname)'" -blur 0x1 "$image_loc"
    gsettings set "org.gnome.desktop.background picture-uri" "file:///$image_loc"
    gsettings set "org.gnome.desktop.background picture-options" "stretched"
}

solarized-terminal-setup () {
    cp "$HOME/.config/xfce4/terminal/$1" "$HOME/.config/xfce4/terminal/terminalrc"
}
solarized-light-terminal-setup () {
    solarized-terminal-setup light
}
solarized-dark-terminal-setup () {
    solarized-terminal-setup dark
}

debian-install-shellcheck () {
    mkdir -p ~/bin;
    cd ~/bin;
    sudo apt-get install ghc libghc-parsec3-dev libghc-json-dev libghc-regex-compat-dev libghc-quickcheck2-dev pandoc;
    git clone git@github.com:koalaman/shellcheck.git;
    cd shellcheck;
    make;
}
