#!/bin/bash -e

if [[ ! -d  ~/.build/AFLplusplus ]]; then

    sudo apt install -y gcc-13-plugin-dev

    # llvm 17
    cd ~/.build
    yes '' | ~/.config/dot/ubuntu/llvm-update.sh 17 20

    # afl++
    cd ~/.build
    rm -rf AFLplusplus
    git clone https://github.com/AFLplusplus/AFLplusplus
    cd AFLplusplus
    make source-only NO_NYX=1
    sudo make install

fi
