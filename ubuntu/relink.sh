#!/bin/bash

function relink() {
    echo ln -s $1 to $2
    rm -rf $2
    ln -s $1 $2
}

# emacs
relink ~/.config/emacs ~/.emacs.d
relink ~/.config/dot/doom.d ~/.config/doom
relink ~/.config/dot/ubuntu/emacs-snap.service ~/.config/systemd/user/emacs.service

# shell
relink ~/.config/dot/shell/zshrc        ~/.zshrc
relink ~/.config/dot/shell/bash_aliases ~/.bash_aliases
relink ~/.config/dot/shell/gitconfig    ~/.gitconfig
relink ~/.config/dot/shell/gitignore    ~/.gitignore

# i3
relink ~/.config/dot/ubuntu/i3               ~/.config/i3/config
relink ~/.config/dot/ubuntu/compton.conf     ~/.config/i3/compton.conf
# rofi
relink ~/.config/dot/ubuntu/rofi/config.rasi ~/.config/rofi/config.rasi
relink ~/.config/dot/ubuntu/rofi/themes      ~/.local/share/rofi/themes

# apps
relink ~/.config/dot/ubuntu/Xresources ~/.Xresources
relink ~/.config/dot/ubuntu/ghostty    ~/.config/ghostty/config
relink ~/.config/dot/ubuntu/zls.json   ~/.config/zls.json
