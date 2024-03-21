#!/bin/bash -e
# TODO   pa ovo radi samo za arm
#
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

    /usr/local/go/bin/go install golang.org/x/tools/gopls@latest
fi
