#!/bin/bash -ex

# copy my ssh keys
if [[ ! -f ~/.ssh/id_rsa ]] ; then
    echo "copy my ssh keys"
    cd ~
    mkdir -p .ssh
    cd .ssh
    cp ~/host/.ssh/authorized_keys2 .
    cp ~/host/.ssh/id_rsa .
    cp ~/host/.ssh/id_rsa.pub .
fi

# sudo without password
if [[ ! -f /etc/sudoers.d/ianic ]] ; then
    cd ~
    echo "sudo without password for ianic"
    echo "ianic ALL=(ALL) NOPASSWD:ALL" > ianic
    sudo mv ianic /etc/sudoers.d/
    sudo chown root:root  /etc/sudoers.d/ianic
fi

