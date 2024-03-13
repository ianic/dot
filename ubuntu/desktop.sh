#!/bin/bash -e

script_dir=$(dirname "${BASH_SOURCE[0]}" ) # this script dir

cd $script_dir
./server.sh

# upgrade server to desktop, don't work on 24.04 desktop
# if ! dpkg --no-pager -l ubuntu-desktop | grep ubuntu-desktop; then
#     echo "install desktop environment"
#     sudo apt update && sudo apt upgrade
#     sudo apt install ubuntu-desktop # ovo traje jakooo dugo
#     sudo reboot
# fi

if [[ -d ~/Videos ]]; then
    echo "remove home folder clutter"
    cd ~
    rm -rf Desktop Documents Downloads Music Pictures Public Templates Videos
fi

if [[ ! -d ~/.fonts ]]; then
    echo "install fonts"
    cd ~
    version=v3.1.0
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
    # ovo mapiranje na 24.04 vise nije potrebno
    # ln -s ~/host/code/dot/ubuntu/Xmodmap ~/.Xmodmap
    # xmodmap ~/.Xmodmap
    ln -s ~/host/code/dot/ubuntu/Xresources ~/.Xresources

    sudo cp ~/host/code/dot/ubuntu/etc-default-keyboard /etc/default/keyboard
    sudo cp ~/host/code/dot/ubuntu/01-fixkeyboard /etc/dconf/db/ibus.d/
fi

# if [[ ! -f /usr/share/xsessions/exwm.desktop ]] ; then
#     sudo cp  ~/host/code/dot/ubuntu/exwm.desktop /usr/share/xsessions/exwm.desktop

#     mkdir -p .config/exwm
#     ln -s ~/host/code/dot/ubuntu/start-exwm.sh .config/exwm/start-exwm.sh
# fi

cd $script_dir
./build-emacs.sh
./emacs.sh

# fix Ubuntu login screen scaling
dpi_fix=/usr/share/glib-2.0/schemas/93_hidpi.gschema.override
if [[ ! -f  $dpi_fix ]]; then
    echo -n "[org.gnome.desktop.interface]\nscaling-factor=2\n" | sudo tee -a $dpi_fix
    sudo glib-compile-schemas /usr/share/glib-2.0/schemas
fi

if [[ ! -f ~/host/code/dot/ubuntu/i3 ]] ; then
    echo "install i3"
    cd ~
    mkdir -p .config/i3
    cd .config/i3
    rm -f config
    ln -s ~/host/code/dot/ubuntu/i3 config

    mkdir -p ~/.config/rofi
    rm ~/.config/rofi/config.rasi
    ln -s ~/host/code/dot/ubuntu/rofi ~/.config/rofi/config.rasi
fi

cd $script_dir
./fuzzing_stack.sh
