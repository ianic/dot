#!/bin/bash -e

# install parallels tools in vm: https://kb.parallels.com/113394
# execute:
# /media/psf/Home/code/dot/ubuntu/server.sh

SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)

if [[ ! -d ~/host ]]; then
    echo "link host folders"
    cd ~
    ln -s /media/psf/Home/ host
    ln -s /media/psf/Home/code code
fi

cd $SCRIPT_DIR

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

echo "install packages"
sudo apt update -y && sudo apt upgrade -y

sudo -E apt install -y curl net-tools unzip make build-essential \
    zsh git fd-find snapd openssh-server htop tree exa \
    jq bat fzf ripgrep \
    linux-libc-dev liburing-dev cmake \
    linux-tools-common linux-tools-generic linux-tools-$(uname -r) \
    gdb hyperfine emacs-nox libtool libtool-bin

# zsh configuration
if [[ ! -d ~/.oh-my-zsh ]]; then
    echo "install zsh"
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
echo "install zig"
sudo update-ca-certificates
./zig.sh

# install websocat from github release
# https://github.com/vi/websocat/releases
if [ ! -x "$(command -v ~/.local/bin/websocat)" ]; then
    echo "install websocat"
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

# Wezterm
# https://wezfurlong.org/wezterm/install/linux.html#installing-on-linux-using-appimage
if [ ! -x "$(command -v wezterm)" ]; then
    echo "install wezterm"
    curl -LO https://github.com/wez/wezterm/releases/download/nightly/wezterm-nightly.Ubuntu22.04.arm64.deb
    sudo apt install -y ./wezterm-nightly.Ubuntu22.04.arm64.deb
    rm wezterm-nightly.Ubuntu22.04.arm64.deb
fi


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
