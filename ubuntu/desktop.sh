#!/bin/bash -ex

# location of my home parallels shared folder from mac host
host_home=/media/psf/Home
if [[ -d /mnt/hgfs/ianic/ ]]; then
    # on vmware this is location
    host_home=/mnt/hgfs/ianic
fi

cd $(dirname "${BASH_SOURCE[0]}" ) # this script dir

./home.sh
./packages.sh
./shell.sh
./emacs.sh
./embeded.sh
./build_tools.sh
./alacritty.sh

# load gnome terminal preferences
# dump:
# dconf dump /org/gnome/terminal/ > gterminal.preferences
# load:
cat gterminal.preferences | dconf load /org/gnome/terminal/


