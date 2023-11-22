#!/bin/bash -e

# install doom emacs
if [[ ! -d ~/.doom.d ]]; then
    echo "install doom emacs"
    git clone --depth 1 https://github.com/doomemacs/doomemacs ~/.config/emacs
    ~/.config/emacs/bin/doom install

    rm -rf ~/.emacs.d
    ln -s ~/.config/emacs ~/.emacs.d

    rm -rf ~/config/doom
    ln -s ~/host/code/dot/doom.d.terminal ~/.config/doom
    ~/.config/emacs/bin/doom sync
fi

# start emacs daemon
if [[ ! -f ~/.config/systemd/user/emacs.service ]]; then
    echo "configure emacs daemon"
    mkdir -p ~/.config/systemd/user
    ln -s ~/host/code/dot/ubuntu/emacs-snap.service ~/.config/systemd/user/emacs.service

    # uncomment to enable
    # systemctl --user daemon-reload
    # systemctl start --user emacs
    # systemctl --user enable emacs

    # commnads to view logs, stop server, view status:
    # journalctl --user -u emacs -f
    # systemctl stop --user emacs
    # systemctl --user status emacs.service
fi


