#!/bin/bash -ex
#
#

if [ ! -f ~/Library/LaunchAgents/gnu.emacs.daemon.plist ]; then
    ln -s ~/code/dot/macos/gnu.emacs.daemon.plist ~/Library/LaunchAgents

    launchctl load -w ~/Library/LaunchAgents/gnu.emacs.daemon.plist
    launchctl start gnu.emacs.daemon
fi
