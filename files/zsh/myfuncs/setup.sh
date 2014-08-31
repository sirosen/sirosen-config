vundle-setup () {
    git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle 2&>/dev/null
    (cd ~/.vim/bundle/vundle && git pull 2&>1 >/dev/null)
    vim +PluginInstall +qall
}

magick-hostname-background-gnome3 () {
    local image_loc="$HOME/Pictures/autogenbg.png"
    convert -size 1440x900 xc:lightgrey -font Palatino-Bold -pointsize 128 -fill black -draw "text 400,300 '`hostname`'" -blur 0x1 "$image_loc"
    gsettings set org.gnome.desktop.background picture-uri file:///"$image_loc"
    gsettings set org.gnome.desktop.background picture-options "stretched"
}

solarized-terminal-setup () {
    case "$1" in
        "dark")
            PALETTE="#070736364242:#D3D301010202:#858599990000:#B5B589890000:#26268B8BD2D2:#D3D336368282:#2A2AA1A19898:#EEEEE8E8D5D5:#00002B2B3636:#CBCB4B4B1616:#58586E6E7575:#65657B7B8383:#838394949696:#6C6C7171C4C4:#9393A1A1A1A1:#FDFDF6F6E3E3"
            BG_COLOR="#00002B2B3636"
            FG_COLOR="#65657B7B8383"
            ;;
        "light")
            PALETTE="#EEEEE8E8D5D5:#D3D301010202:#858599990000:#B5B589890000:#26268B8BD2D2:#D3D336368282:#2A2AA1A19898:#070736364242:#FDFDF6F6E3E3:#CBCB4B4B1616:#9393A1A1A1A1:#838394949696:#65657B7B8383:#6C6C7171C4C4:#58586E6E7575:#00002B2B3636"
            BG_COLOR="#FDFDF6F6E3E3"
            FG_COLOR="#838394949696"
            ;;
        *)
            echo "Usage: solarize [light | dark]"
            exit
            ;;
    esac

    gconftool-2 --set "/apps/gnome-terminal/profiles/Default/use_theme_background" --type bool false
    gconftool-2 --set "/apps/gnome-terminal/profiles/Default/use_theme_colors" --type bool false
    gconftool-2 --set "/apps/gnome-terminal/profiles/Default/palette" --type string "$PALETTE"
    gconftool-2 --set "/apps/gnome-terminal/profiles/Default/background_color" --type string "$BG_COLOR"
    gconftool-2 --set "/apps/gnome-terminal/profiles/Default/foreground_color" --type string "$FG_COLOR"
}
solarized-light-terminal-setup () { solarized-terminal-setup light }
solarized-dark-terminal-setup () { solarized-terminal-setup dark }

debian-install-shellcheck () {
    cd ~/bin;
    sudo apt-get install ghc libghc-parsec3-dev libghc-json-dev libghc-regex-compat-dev libghc-quickcheck2-dev pandoc;
    git clone git@github.com:koalaman/shellcheck.git;
    cd shellcheck;
    make;
}
