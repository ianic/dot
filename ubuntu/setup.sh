#!/bin/bash -ex

if [[ ! -d ~/host ]]; then
   cd ~
   ln -s /media/psf/Home/code/dot dot
   ln -s /media/psf/Home/ host
   ln -s /media/psf/Home/code code
fi

cd $(dirname "${BASH_SOURCE[0]}" ) # this script dir

./home.sh
./packages.sh
./shell.sh
./alacritty.sh
./emacs.sh

# load gnome terminal preferences
# dump:
# dconf dump /org/gnome/terminal/ > gterminal.preferences
# load:
cat gterminal.preferences | dconf load /org/gnome/terminal/

# free Ctrl-; from globaly used by the system
# ref: https://unix.stackexchange.com/questions/692237/ctrl-displays-e-character-and-captures-the-keyboard-shortcut
gsettings set org.freedesktop.ibus.panel.emoji hotkey "[]"
