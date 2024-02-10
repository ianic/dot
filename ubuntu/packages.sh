#!/bin/bash -e

sudo apt update -y && sudo apt upgrade -y

sudo -E apt install -y curl net-tools unzip make build-essential \
    zsh git fd-find snapd openssh-server htop tree exa \
    jq bat fzf ripgrep \
    linux-libc-dev liburing-dev cmake \
    linux-tools-common linux-tools-generic linux-tools-$(uname -r) \
    gdb hyperfine emacs-nox libtool libtool-bin \
    qemu-user-static \
    ruby-full

sudo snap install emacs --classic

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

    go install golang.org/x/tools/gopls@latest
fi

# Wezterm
# https://wezfurlong.org/wezterm/install/linux.html#installing-on-linux-using-appimage
# if [ ! -x "$(command -v wezterm)" ]; then
#     echo "install wezterm"
#     curl -LO https://github.com/wez/wezterm/releases/download/nightly/wezterm-nightly.Ubuntu22.04.arm64.deb
#     sudo apt install -y ./wezterm-nightly.Ubuntu22.04.arm64.deb
#     rm wezterm-nightly.Ubuntu22.04.arm64.deb
# fi

# wasmtime
curl https://wasmtime.dev/install.sh -sSf | bash

# sudo apt install -y fswatch

# za Zig build
sudo apt-get -y install clang-17 lldb-17 lld-17 liblld-17 liblld-17-dev
