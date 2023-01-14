#!/bin/bash -ex

#installs zig into /usr/local/bin


cd /Users/ianic/code/zig/zig-build/zig-my-first-issue

mkdir build
cd build
cmake .. -DZIG_STATIC_LLVM=ON -DCMAKE_PREFIX_PATH="$(brew --prefix llvm);$(brew --prefix zstd)"
make install

cd stage3
version=$(bin/zig version)

sudo mkdir -p /usr/local/zig/"$version"
sudo cp bin/zig /usr/local/zig/"$version"/zig
sudo cp -r lib/zig /usr/local/zig/"$version"/lib

sudo rm -f /usr/local/bin/zig
sudo ln -s /usr/local/zig/$version/zig /usr/local/bin/
