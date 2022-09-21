#!/bin/bash -ex

if [[ -d ~/Documents ]]; then
    echo "remove home folder clutter"
    rm -rf Desktop/ Documents/ Downloads/ Music/ Pictures/ Public/ Templates/ Videos/
fi

if [[ ! -d ~/code ]]; then
    echo "link code to ~"
    cd ~
    ln -s $host_home/code/ .
fi

if [[ ! -f ~/.ssh/id_rsa ]] ; then
    echo "copy my ssh keys"
    cd ~
    mkdir -p .ssh
    cd .ssh
    cp $host_home/.ssh/authorized_keys2 .
    cp $host_home/.ssh/id_rsa .
    cp $host_home/.ssh/id_rsa.pub .
fi

if [[ ! -f /etc/sudoers.d/ianic ]] ; then
    cd ~
    echo "sudo without password for ianic"
    echo "ianic ALL=(ALL) NOPASSWD:ALL" > ianic
    sudo mv ianic /etc/sudoers.d/
    sudo chown root:root  /etc/sudoers.d/ianic
fi
