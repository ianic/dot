#!/bin/bash -e

script_dir=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
source $script_dir/functions.sh

sudo apt update -y && sudo apt upgrade -y
sudo update-ca-certificates

sudo -E apt install -y curl net-tools unzip make build-essential \
    zsh git fd-find snapd openssh-server htop tree \
    jq bat fzf ripgrep \
    linux-libc-dev liburing-dev cmake \
    linux-tools-common linux-tools-generic linux-tools-$(uname -r) \
    gdb hyperfine emacs-nox libtool libtool-bin \
    qemu-user-static \
    ruby-full \
    clang-17 lldb-17 lld-17 liblld-17 liblld-17-dev \
    libgtk-4-dev libadwaita-1-dev 


if [[ ! -d ~/.wasmtime ]]; then
    echo "install wasmtime"
    curl https://wasmtime.dev/install.sh -sSf | bash
fi

if [[ ! -f /etc/apt/keyrings/gierens.gpg ]]; then
    echo "install eza"
    # ref: https://github.com/eza-community/eza/blob/main/INSTALL.md
    sudo mkdir -p /etc/apt/keyrings
    wget -qO- https://raw.githubusercontent.com/eza-community/eza/main/deb.asc | sudo gpg --dearmor -o /etc/apt/keyrings/gierens.gpg
    echo "deb [signed-by=/etc/apt/keyrings/gierens.gpg] http://deb.gierens.de stable main" | sudo tee /etc/apt/sources.list.d/gierens.list
    sudo chmod 644 /etc/apt/keyrings/gierens.gpg /etc/apt/sources.list.d/gierens.list
    sudo apt update
    sudo apt install -y eza
fi

if [ ! -x "$(command -v watchexec)" ]; then
    echo "install watchexec file system watcher"
    wget https://github.com/watchexec/watchexec/releases/download/v1.25.1/watchexec-1.25.1-x86_64-unknown-linux-gnu.deb
    sudo apt install ./watchexec-1.25.1-x86_64-unknown-linux-gnu.deb
    rm watchexec-1.25.1-x86_64-unknown-linux-gnu.deb
fi

echo "install zig"
$script_dir/zig.sh
$script_dir/fuzzing_stack.sh
$script_dir/ghostty.sh

cd ~/.build
if [[ ! -f google-chrome-stable_current_amd64.deb ]]; then
    echo "install Chrome"
    wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
    sudo apt install -y ./google-chrome-stable_current_amd64.deb
fi
