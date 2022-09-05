#!/bin/bash -ex

host_home=/media/psf/Home/

# on vmware this is location
if [[ -d /mnt/hgfs/ianic/ ]]; then
    host_home=/mnt/hgfs/ianic/
fi

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
    cp $host_home.ssh/authorized_keys2 .
    cp $host_home.ssh/id_rsa .
    cp $host_home.ssh/id_rsa.pub .
fi

if [[ ! -f /etc/sudoers.d/ianic ]] ; then
    cd ~
    echo "sudo without password for ianic"
    echo "ianic ALL=(ALL) NOPASSWD:ALL" > ianic
    sudo mv ianic /etc/sudoers.d/
    sudo chown root:root  /etc/sudoers.d/ianic
fi

sudo apt-get update -y
sudo apt-get upgrade -y

sudo -E apt-get install -y curl net-tools unzip make build-essential jq zsh git ripgrep fd-find snapd openssh-server htop ruby-full tree
sudo -E apt-get install -y i3 rofi dzen2
sudo -E snap install go --classic
sudo -E snap install emacs --classic
sudo -E usermod --shell /usr/bin/zsh ianic

if [[ ! -d ~/.oh-my-zsh ]]; then
    echo "install zsh"
    git clone https://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
    export ZSH_CUSTOM=~/.oh-my-zsh/custom
    git clone https://github.com/zsh-users/zsh-completions ${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions
    git clone https://github.com/spaceship-prompt/spaceship-prompt.git "$ZSH_CUSTOM/themes/spaceship-prompt" --depth=1
    ln -s "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH_CUSTOM/themes/spaceship.zsh-theme"

    echo "install lsd tool"
    # https://github.com/Peltoche/lsd/releases
    wget -q https://github.com/Peltoche/lsd/releases/download/0.21.0/lsd_0.21.0_arm64.deb
    sudo dpkg -i lsd_0.21.0_arm64.deb
    rm lsd_0.21.0_arm64.deb

    # disable screen lock
    gsettings set org.gnome.desktop.screensaver lock-enabled false
fi

if [[ ! -f ~/.zshrc ]]; then
    echo "link my shell configs"
    cd ~
    ln -s ~/code/dot/shell/zshrc        .zshrc
    ln -s ~/code/dot/shell/bash_aliases .bash_aliases
    ln -s ~/code/dot/shell/gitconfig    .gitconfig
    ln -s ~/code/dot/shell/gitignore    .gitignore

    mkdir -p ~/.config/i3
    ln -s ~/code/dot/ubuntu/i3 ~/.config/i3/config

    mkdir -p ~/.config/i3status
    ln -s /home/ianic/code/dot/ubuntu/i3status ~/.config/i3status/config
fi

if [[ ! -d ~/.fonts ]]; then
    echo "install font"
    cd ~
    wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/UbuntuMono.zip
    wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/Hack.zip
    wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/Meslo.zip
    wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/SourceCodePro.zip

    unzip SourceCodePro.zip -d ~/.fonts
    unzip UbuntuMono.zip -d ~/.fonts
    unzip Hack.zip -d ~/.fonts
    unzip Meslo.zip -d ~/.fonts
    fc-cache -fv
    rm -f UbuntuMono.zip Hack.zip Meslo.zip SourceCodePro.zip

    sudo apt install fonts-firacode
fi

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



# TODO: gnome terminal preferences
# dump:
# dconf dump /org/gnome/terminal/ > gterminal.preferences
# load:
# cat gterminal.preferences | dconf load /org/gnome/terminal/


# vmware enable shared folders:
#
# sudo apt install -y open-vm-tools-desktop
# sudo reboot now
# sudo mkdir -p /mnt/hgfs/
# sudo /usr/bin/vmhgfs-fuse .host:/ /mnt/hgfs/ -o subtype=vmhgfs-fuse,allow_other

# for working with st
sudo apt-get install -y stlink-tools
