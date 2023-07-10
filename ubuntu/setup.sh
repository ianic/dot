#!/bin/bash -ex

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

if [[ ! -d ~/host ]]; then
   cd ~
   # ln -s /media/psf/Home/code/dot dot
   ln -s /media/psf/Home/ host
   ln -s /media/psf/Home/code code
fi

cd $SCRIPT_DIR

./home.sh
./packages.sh
./shell.sh
./alacritty.sh
./emacs.sh
./zig.sh

# load gnome terminal preferences
# dump:
# dconf dump /org/gnome/terminal/ > gterminal.preferences
# load:
cat gterminal.preferences | dconf load /org/gnome/terminal/

# free Ctrl-; from globaly used by the system
# ref: https://unix.stackexchange.com/questions/692237/ctrl-displays-e-character-and-captures-the-keyboard-shortcut
gsettings set org.freedesktop.ibus.panel.emoji hotkey "[]"

# disable screen saver and prevent the monitor's DPMS energy saver from kicking
# from: https://askubuntu.com/questions/177348/how-do-i-disable-the-screensaver-lock
xset s off
xset s noblank
xset -dpms
