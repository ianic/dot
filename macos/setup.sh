#!/bin/bash -ex
#
#

# install all homebrew packages
brew bundle --file Brewfile

# Ref: https://developer.apple.com/forums/thread/665661
if [ ! -f ~/Library/LaunchAgents/gnu.emacs.daemon.plist ]; then
    ln -s ~/code/dot/macos/gnu.emacs.daemon.plist ~/Library/LaunchAgents

    launchctl load -w ~/Library/LaunchAgents/gnu.emacs.daemon.plist
    launchctl start gnu.emacs.daemon
fi

if [ ! -f ~/.config/lsd/ ]; then
    mkdir -p ~/.config/lsd/
    ln -s ~/code/dot/shell/lsd_config.yml ~/.config/lsd/config.yaml
fi


# notes
# generate Brewfile from current system
# brew bundle dump
# install all packages from Brewfile
# brew bundle
