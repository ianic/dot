#!/bin/bash -e

script_dir=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
source $script_dir/functions.sh

echo "before zig version: $(zig version)"

cd ~/Code/zig/build2
ninja install
stage3/bin/zig build -p stage4 -Denable-llvm -Doptimize=ReleaseFast # -Dno-lib

version=$(stage4/bin/zig version)
dir=/usr/local/zig/master-$version
if [[ -d $dir ]]; then
    sudo rm -rf $dir
fi
sudo mv stage4 $dir

sudo rm -f /usr/local/bin/zig
sudo ln -s $dir/bin/zig /usr/local/bin/

echo "after zig version: $(zig version)"


# zls install from source
build_root=~/.build
cd ~ && mkdir -p $build_root && cd $build_root
if [[ ! -d $build_root/zls ]]; then
    git clone --recurse-submodules https://github.com/zigtools/zls
    cd zls
else
    cd zls
    git pull
fi
zig build -Doptimize=ReleaseSafe

mkdir -p ~/.local/bin
rm ~/.local/bin/zls || true
cp ./zig-out/bin/zls ~/.local/bin
link ~/.config/dot/ubuntu/zls.json ~/.config/.zls.json
# reload zls in emacs
killall zls
