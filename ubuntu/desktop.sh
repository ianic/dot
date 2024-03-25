#!/bin/bash -e
#
# Na novom stroju prvo napravim:
# r$ sudo apt install openssh-server git
# l$ ./copy_ssh_keys.sh ip-address-of-new-server
# r$ mkdir -p .config && cd .config && git clone git@github.com:ianic/dot.git
# r$ ~/.config/dot/ubuntu/desktop.sh
#
# add samba configuration
# add this host to callisto, add calisto to this /etc/hosts
# check crontab

script_dir=$(dirname "${BASH_SOURCE[0]}" )
source $script_dir/functions.sh

$script_dir/server.sh

if [[ -d ~/Videos ]]; then
    echo "remove home folder clutter"
    cd ~
    rm -rf Desktop Documents Downloads Music Pictures Public Templates Videos
fi

if [[ ! -d ~/.fonts ]]; then
    echo "install fonts"
    cd ~
    version=v3.1.1
    wget https://github.com/ryanoasis/nerd-fonts/releases/download/$version/UbuntuMono.zip
    wget https://github.com/ryanoasis/nerd-fonts/releases/download/$version/Hack.zip
    wget https://github.com/ryanoasis/nerd-fonts/releases/download/$version/Meslo.zip
    wget https://github.com/ryanoasis/nerd-fonts/releases/download/$version/SourceCodePro.zip
    wget https://github.com/ryanoasis/nerd-fonts/releases/download/$version/JetBrainsMono.zip

    unzip -o SourceCodePro.zip -d ~/.fonts
    unzip -o UbuntuMono.zip -d ~/.fonts
    unzip -o Hack.zip -d ~/.fonts
    unzip -o Meslo.zip -d ~/.fonts
    unzip -o JetBrainsMono.zip -d ~/.fonts
    rm -f UbuntuMono.zip Hack.zip Meslo.zip SourceCodePro.zip JetBrainsMono.zip

    fc-cache -fv
    sudo apt install fonts-firacode
fi


# emacs
$script_dir/build-emacs.sh
$script_dir/emacs.sh

if [[ ! -f ~/.config/i3/config ]] ; then
    # i3
    link ~/.config/dot/ubuntu/i3               ~/.config/i3/config
    link ~/.config/dot/ubuntu/compton.conf     ~/.config/i3/compton.conf
    # rofi
    link ~/.config/dot/ubuntu/rofi/config.rasi ~/.config/rofi/config.rasi
    link ~/.config/dot/ubuntu/rofi/themes      ~/.local/share/rofi/themes
fi

if [ $(hostname) = "io" ]; then

    if [[ ! -f ~/.Xmodmap ]] ; then
        link ~/.config/dot/ubuntu/Xresources ~/.Xresources
        sudo cp ~/.config/dot/ubuntu/etc-default-keyboard /etc/default/keyboard
        sudo cp ~/.config/dot/ubuntu/01-fixkeyboard       /etc/dconf/db/ibus.d/
    fi

    # fix Ubuntu login screen scaling
    # fails with [org.gnome.desktop.interface]\nscaling-factor=2\n/usr/share/glib-2.0/schemas/93_hidpi.gschema.override: Key file does not start with a group.  Ignoring this file.
    dpi_fix=/usr/share/glib-2.0/schemas/93_hidpi.gschema.override
    if [[ ! -f  $dpi_fix ]]; then
        echo "[org.gnome.desktop.interface]\nscaling-factor=2" | sudo tee -a $dpi_fix
        sudo glib-compile-schemas /usr/share/glib-2.0/schemas
    fi
fi
