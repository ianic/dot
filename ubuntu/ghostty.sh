#!/bin/bash -e

cd ~/.build

if [[ ! -d ghostty ]]; then
    git clone git@github.com:mitchellh/ghostty.git
    cd ghostty
else
    cd ghostty
    git pull
fi

zig build -p $HOME/.local -Doptimize=ReleaseFast
#zig build -Doptimize=ReleaseFast
#sudo cp zig-out/bin/ghostty /usr/local/bin

mkdir -p ~/.config/ghostty
rm -f ~/.config/ghostty/config
ln -s ~/.config/dot/ubuntu/ghostty ~/.config/ghostty/config
