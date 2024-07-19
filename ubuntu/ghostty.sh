#!/bin/bash -e

script_dir=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
source $script_dir/functions.sh


git_clone git@github.com:mitchellh/ghostty.git ~/.build/ghostty
cd ~/.build/ghostty

/usr/local/zig/zig-linux-x86_64-0.13.0/zig build -p $HOME/.local -Doptimize=ReleaseFast
# zig build -p $HOME/.local -Doptimize=ReleaseFast

link ~/.config/dot/ubuntu/ghostty ~/.config/ghostty/config
