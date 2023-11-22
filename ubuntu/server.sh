#!/bin/bash -e

# install parallels tools in vm: https://kb.parallels.com/113394
# execute:
# /media/psf/Home/code/dot/ubuntu/server.sh

SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)

CN='\033[0;32m'
NC='\033[0m' # No Color

if [[ ! -d ~/host ]]; then
    printf "${CN}link host folders${NC}\n"
    cd ~
    ln -s /media/psf/Home/ host
    ln -s /media/psf/Home/code code
fi

cd $SCRIPT_DIR

if [[ ! -f ~/.ssh/id_rsa ]]; then
    printf "${CN}copy my ssh keys${NC}\n"
    cd ~
    mkdir -p .ssh
    cd .ssh
    cp ~/host/.ssh/authorized_keys2 .
    cp ~/host/.ssh/id_rsa .
    cp ~/host/.ssh/id_rsa.pub .
fi

if [[ ! -f /etc/sudoers.d/ianic ]]; then
    cd ~
    printf "${CN}sudo without password for ianic${NC}\n"
    echo "ianic ALL=(ALL) NOPASSWD:ALL" >ianic
    sudo mv ianic /etc/sudoers.d/
    sudo chown root:root /etc/sudoers.d/ianic
fi

printf "${CN}install packages ${NC}\n"
sudo apt update -y
sudo apt upgrade -y

sudo -E apt install -y curl net-tools unzip make build-essential \
    zsh git fd-find snapd openssh-server htop tree exa \
    jq bat fzf ripgrep \
    linux-libc-dev liburing-dev cmake \
    linux-tools-common linux-tools-generic linux-tools-$(uname -r) \
    gdb hyperfine emacs-nox libtool libtool-bin

# zsh configuration
if [[ ! -d ~/.oh-my-zsh ]]; then
    printf "${CN}install zsh${NC}\n"
    # set zsh as default shell
    sudo -E usermod --shell /usr/bin/zsh ianic

    git clone https://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
    export ZSH_CUSTOM=~/.oh-my-zsh/custom
    git clone https://github.com/zsh-users/zsh-completions ${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions
    git clone https://github.com/spaceship-prompt/spaceship-prompt.git "$ZSH_CUSTOM/themes/spaceship-prompt" --depth=1
    ln -s "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH_CUSTOM/themes/spaceship.zsh-theme"
fi

if [[ ! -f ~/.zshrc ]]; then
    printf "${CN}link my shell configs${NC}\n"
    cd ~
    ln -s ~/host/code/dot/shell/zshrc .zshrc
    ln -s ~/host/code/dot/shell/bash_aliases .bash_aliases
    ln -s ~/host/code/dot/shell/gitconfig .gitconfig
    ln -s ~/host/code/dot/shell/gitignore .gitignore
fi

cd $SCRIPT_DIR
printf "${CN}install zig${NC}\n"
sudo update-ca-certificates
./zig.sh

# install websocat from github release
# https://github.com/vi/websocat/releases
if [ ! -x "$(command -v ~/.local/bin/websocat)" ]; then
    printf "${CN}install websocat ${NC}\n"
    wget https://github.com/vi/websocat/releases/download/v1.11.0/websocat.aarch64-unknown-linux-musl &&
        mv websocat.aarch64-unknown-linux-musl ~/.local/bin/websocat &&
        chmod +x ~/.local/bin/websocat
fi

# Go install
[ -x "$(command -v /usr/local/go/bin/go)" ] && current_version=$(curl -s "https://go.dev/VERSION?m=text" | head -n 1)
version=$(curl -s https://go.dev/VERSION?m=text | head -n 1)
if [[ "$version" != "$current_version" ]]; then
    echo "install Go version: $version"
    wget https://go.dev/dl/$version.linux-arm64.tar.gz
    sudo rm -rf /usr/local/go && sudo tar -C /usr/local -xzf $version.linux-arm64.tar.gz
    rm $version.linux-arm64.tar.gz
fi

# experimental
sudo systemctl stop snapd

printf "${CN}done ${NC}\n"

# clanup
# pkill zig; pkill test; pkill node; pkill code-insiders

# Notes, o tome sto fali
# dodao sam jos i wezterm: wget deb package i onda apt get toga
#
# doom emacs sam instalirao kako on kaze u .local i onda linkao moj config tamo u local
# rm ~/config/doom && ln -s ~/code/dot/doom.d.terminal ~/.confg/doom
#
# dodao sam i cron job koji kopira sve sto je bitno u backup da to ode u cloud
