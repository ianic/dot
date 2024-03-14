#!/bin/bash -ex

# Vanilla Emacs requirements
sudo apt install -y make build-essential autoconf texinfo libx11-dev xserver-xorg-dev xorg-dev
sudo apt install -y libxpm-dev libjpeg-dev libgif-dev libtiff-dev libpng-dev libgnutls28-dev \
    libncurses-dev libgccjit-12-dev libharfbuzz-dev libcairo2-dev libacl1-dev
# pgtk
sudo apt install -y libgtk-3-dev
# Native JSON
sudo apt install -y libjansson4 libjansson-dev
# Native compilation
sudo apt install -y libgccjit0 libgccjit-13-dev


cd ~/.build
if [[ ! -d ~/.build/emacs ]]; then
    git clone https://git.savannah.gnu.org/git/emacs.git -b emacs-29
    git clone https://github.com/tree-sitter/tree-sitter.git
else
    if [[ ${#} -ne 1 ]]; then
        echo "add argument to force rebuild"
        exit 0
    fi
    cd emacs
    git pull
    cd ../tree-sitter
    git pull
fi

# Build tree sitter
cd ~/.build/tree-sitter/
make
sudo make install

# Build emacs
cd ~/.build/emacs
./autogen.sh
./configure --with-tree-sitter --with-native-compilation --without-pop --with-json --with-x-toolkit=gtk3 CC=gcc-13
make -j$(nproc)
sudo make install

# Install doom and native compile for new binary
if [[ -d ~/.config/emacs ]]; then
    ~/.config/emacs/bin/doom sync
fi

# Reference:
# https://batsov.com/articles/2021/12/19/building-emacs-from-source-with-pgtk/
# https://www.masteringemacs.org/article/how-to-get-started-tree-sitter
#
# This flag is for wayland
# ./configure --with-tree-sitter --with-native-compilation --without-pop --with-json --with-pgtk CC=gcc-13
# ./configure --help
