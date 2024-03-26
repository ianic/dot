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
    i3 rofi dzen2 feh compton \
    clang-17 lldb-17 lld-17 liblld-17 liblld-17-dev \
    libgtk-4-dev libadwaita-1-dev \
    maim xclip copyq

if [[ ! -d ~/.wasmtime ]]; then
    # wasmtime
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


# Note.
# Needed to update: /etc/apt/sources.list.d/archive_uri-http_apt_llvm_org_noble_-noble.list to:
#
# $ cat /etc/apt/sources.list.d/archive_uri-http_apt_llvm_org_noble_-noble.list
# deb [trusted=yes] http://apt.llvm.org/noble/ llvm-toolchain-noble main
# # deb-src http://apt.llvm.org/noble/ llvm-toolchain-noble-17 main
#
# Vecause update was failing.
