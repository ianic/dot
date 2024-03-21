#!/bin/bash -e

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

if [[ ! -f ~/.Xmodmap ]] ; then
    link ~/.config/dot/ubuntu/Xresources ~/.Xresources
    sudo cp ~/.config/dot/ubuntu/etc-default-keyboard /etc/default/keyboard
    sudo cp ~/.config/dot/ubuntu/01-fixkeyboard       /etc/dconf/db/ibus.d/
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

# fix Ubuntu login screen scaling
dpi_fix=/usr/share/glib-2.0/schemas/93_hidpi.gschema.override
if [[ ! -f  $dpi_fix ]]; then
    echo -n "[org.gnome.desktop.interface]\nscaling-factor=2\n" | sudo tee -a $dpi_fix
    sudo glib-compile-schemas /usr/share/glib-2.0/schemas
fi
