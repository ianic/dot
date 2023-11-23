#!/bin/bash -e

cd $(dirname "${BASH_SOURCE[0]}" ) # this script dir

./server.sh

if ! dpkg --no-pager -l ubuntu-desktop | grep ubuntu-desktop; then
    echo "install desktop environment"
    sudo apt update && sudo apt upgrade
    sudo apt install ubuntu-desktop # ovo traje jakooo dugo
    sudo reboot
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
    ln -s ~/host/code/dot/ubuntu/Xmodmap ~/.Xmodmap
    xmodmap ~/.Xmodmap

    sudo cp ~/host/code/dot/ubuntu/etc-default-keyboard /etc/default/keyboard
fi

if [[ ! -f /usr/share/xsessions/exwm.desktop ]] ; then
    sudo cp  ~/host/code/dot/ubuntu/exwm.desktop /usr/share/xsessions/exwm.desktop

    mkdir -p .config/exwm
    ln -s ~/host/code/dot/ubuntu/start-exwm.sh .config/exwm/start-exwm.sh
fi

./emacs.sh

# fix Ubuntu login screen scaling
dpi_fix=/usr/share/glib-2.0/schemas/93_hidpi.gschema.override
if [[ ! -f  $dpi_fix ]]; then
    echo "[org.gnome.desktop.interface]\nscaling-factor=2\n" | sudo tee -a $dpi_fix
    sudo glib-compile-schemas /usr/share/glib-2.0/schemas
fi
