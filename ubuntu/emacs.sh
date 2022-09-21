#!/bin/bash -ex

# install doom emacs
if [[ ! -d ~/.doom.d ]]; then
    echo "domm emacs"
    cd ~
    rm -rf .emacs.d
    git clone --depth 1 https://github.com/hlissner/doom-emacs ~/.emacs.d
    ~/.emacs.d/bin/doom install

    rm -rf .doom.d
    ln -s code/dot/doom.d .doom.d
    ~/.emacs.d/bin/doom sync
fi

# start emacs daemon
if [[ ! -f ~/.config/systemd/user/emacs.service ]]; then
    mkdir -p ~/.config/systemd/user
    ln -s ~/code/dot/ubuntu/emacs.service ~/.config/systemd/user
    systemctl --user daemon-reload
    systemctl start --user emacs
    # commnads to view logs, stop server, view status:
    # journalctl --user -u emacs -f
    # systemctl stop --user emacs
    # systemctl --user status emacs.service
fi


