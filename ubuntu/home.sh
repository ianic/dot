#!/bin/bash -ex

if [[ -d ~/Documents ]]; then
    echo "remove home folder clutter"
    cd ~
    rm -rf Desktop/ Documents/ Music/ Pictures/ Public/ Templates/ Videos/ #Downloads/
fi

# if [[ ! -d ~/code ]]; then
#     echo "link code to ~"
#     cd ~
#     ln -s $host_home/code/ .
# fi

if [[ ! -f ~/.ssh/id_rsa ]] ; then
    echo "copy my ssh keys"
    cd ~
    mkdir -p .ssh
    cd .ssh
    cp ~/host/.ssh/authorized_keys2 .
    cp ~/host/.ssh/id_rsa .
    cp ~/host/.ssh/id_rsa.pub .
fi

if [[ ! -f /etc/sudoers.d/ianic ]] ; then
    cd ~
    echo "sudo without password for ianic"
    echo "ianic ALL=(ALL) NOPASSWD:ALL" > ianic
    sudo mv ianic /etc/sudoers.d/
    sudo chown root:root  /etc/sudoers.d/ianic
fi

if [[ ! -f ~/.Xmodmap ]] ; then
    ln -s ~/dot/ubuntu/Xmodmap ~/.Xmodmap
fi
sudo cp ~/dot/ubuntu/etc-default-keyboard /etc/default/keyboard
