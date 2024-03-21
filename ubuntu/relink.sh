#!/bin/bash

script_dir=$(dirname "${BASH_SOURCE[0]}" ) # this script dir
cd $script_dir
source functions.sh

# emacs
link ~/.config/emacs ~/.emacs.d
link ~/.config/dot/doom.d ~/.config/doom
link ~/.config/dot/ubuntu/emacs-snap.service ~/.config/systemd/user/emacs.service

# shell
link ~/.config/dot/shell/zshrc        ~/.zshrc
link ~/.config/dot/shell/bash_aliases ~/.bash_aliases
link ~/.config/dot/shell/gitconfig    ~/.gitconfig
link ~/.config/dot/shell/gitignore    ~/.gitignore

# i3
link ~/.config/dot/ubuntu/i3               ~/.config/i3/config
link ~/.config/dot/ubuntu/compton.conf     ~/.config/i3/compton.conf
# rofi
link ~/.config/dot/ubuntu/rofi/config.rasi ~/.config/rofi/config.rasi
link ~/.config/dot/ubuntu/rofi/themes      ~/.local/share/rofi/themes

# apps
link ~/.config/dot/ubuntu/Xresources ~/.Xresources
link ~/.config/dot/ubuntu/ghostty    ~/.config/ghostty/config
link ~/.config/dot/ubuntu/zls.json   ~/.config/zls.json
