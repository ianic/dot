#!/bin/bash -e

# install parallels tools in vm: https://kb.parallels.com/113394
# execute:
# /media/psf/Home/code/dot/ubuntu/server.sh

SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)
cd $SCRIPT_DIR

if [[ ! -d ~/host ]]; then
    echo "link host folders"
    cd ~
    ln -s /media/psf/Home/ host
    ln -s /media/psf/Home/code code
fi

if [[ ! -f ~/.ssh/id_rsa ]]; then
    echo "copy my ssh keys"
    cd ~
    mkdir -p .ssh
    cd .ssh
    cp ~/host/.ssh/authorized_keys2 .
    cp ~/host/.ssh/id_rsa .
    cp ~/host/.ssh/id_rsa.pub .
fi

if [[ ! -f /etc/sudoers.d/ianic ]]; then
    cd ~
    echo "sudo without password for ianic"
    echo "ianic ALL=(ALL) NOPASSWD:ALL" >ianic
    sudo mv ianic /etc/sudoers.d/
    sudo chown root:root /etc/sudoers.d/ianic
fi

# zsh configuration
if [[ ! -d ~/.oh-my-zsh ]]; then
    echo "install zsh"
    sudo -E apt install -y zsh git
    # set zsh as default shell
    sudo -E usermod --shell /usr/bin/zsh ianic

    git clone https://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
    export ZSH_CUSTOM=~/.oh-my-zsh/custom
    git clone https://github.com/zsh-users/zsh-completions ${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions
    git clone https://github.com/spaceship-prompt/spaceship-prompt.git "$ZSH_CUSTOM/themes/spaceship-prompt" --depth=1
    ln -s "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH_CUSTOM/themes/spaceship.zsh-theme"
fi

if [[ ! -f ~/.zshrc ]]; then
    echo "link my shell configs"
    cd ~
    ln -s ~/host/code/dot/shell/zshrc .zshrc
    ln -s ~/host/code/dot/shell/bash_aliases .bash_aliases
    ln -s ~/host/code/dot/shell/gitconfig .gitconfig
    ln -s ~/host/code/dot/shell/gitignore .gitignore
fi

cd $SCRIPT_DIR

echo "install packages"
./packages.sh

echo "install zig"
sudo update-ca-certificates
./zig.sh

if ! crontab -l ; then
    echo "adding crontab"
    tmpfile=$(mktemp /tmp/crontab-XXXXXX); echo $tmpfile;
    echo "*/5 * * * * /home/ianic/code/dot/ubuntu/backup.sh 2>&1 >> /dev/null" > $tmpfile
    crontab $tmpfile
    rm $tmpfile
fi


# experimental
# sudo systemctl stop snapd

# echo "done"

# clanup
# pkill zig; pkill test; pkill node; pkill code-insiders

# Notes, o tome sto fali
# dodao sam jos i wezterm: wget deb package i onda apt get toga
#
#
# dodao sam i cron job koji kopira sve sto je bitno u backup da to ode u cloud
