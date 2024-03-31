#!/bin/bash -e

sudo apt update -y && sudo apt upgrade -y

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

# wasmtime
if [[ ! -d ~/.wasmtime ]]; then
    curl https://wasmtime.dev/install.sh -sSf | bash
fi


if [[ ! -f /etc/apt/keyrings/gierens.gpg ]]; then
    # eza install
    # ref: https://github.com/eza-community/eza/blob/main/INSTALL.md
    sudo mkdir -p /etc/apt/keyrings
    wget -qO- https://raw.githubusercontent.com/eza-community/eza/main/deb.asc | sudo gpg --dearmor -o /etc/apt/keyrings/gierens.gpg
    echo "deb [signed-by=/etc/apt/keyrings/gierens.gpg] http://deb.gierens.de stable main" | sudo tee /etc/apt/sources.list.d/gierens.list
    sudo chmod 644 /etc/apt/keyrings/gierens.gpg /etc/apt/sources.list.d/gierens.list
    sudo apt update
    sudo apt install -y eza
fi

# watchexec file system watcher
if [ ! -x "$(command -v watchexec)" ]; then
    wget https://github.com/watchexec/watchexec/releases/download/v1.25.1/watchexec-1.25.1-x86_64-unknown-linux-gnu.deb
    sudo apt install ./watchexec-1.25.1-x86_64-unknown-linux-gnu.deb
    rm watchexec-1.25.1-x86_64-unknown-linux-gnu.deb
fi

# Note for Ubuntu 24.04 development version
# Needed to update: /etc/apt/sources.list.d/archive_uri-http_apt_llvm_org_noble_-noble.list to:
#
# $ cat /etc/apt/sources.list.d/archive_uri-http_apt_llvm_org_noble_-noble.list
# deb [trusted=yes] http://apt.llvm.org/noble/ llvm-toolchain-noble main
# # deb-src http://apt.llvm.org/noble/ llvm-toolchain-noble-17 main
#
# Because update was failing.
