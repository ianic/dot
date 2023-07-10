#!/bin/bash -ex



# sudo sed -i.bak 's/^# *deb-src/deb-src/g' /etc/apt/sources.list && \
#    sudo apt-get update

sudo apt install -y make build-essential autoconf texinfo libx11-dev xserver-xorg-dev xorg-dev
sudo apt install -y libxpm-dev libjpeg-dev libgif-dev libtiff-dev libgnutls28-dev libncurses-dev libgccjit-12-dev libharfbuzz-dev libcairo2-dev libacl1-dev

cd ~/src

git clone https://git.savannah.gnu.org/git/emacs.git -b emacs-29
git clone git@github.com:tree-sitter/tree-sitter.git

cd tree-sitter/
make
sudo make install
cd -

cd emacs
./autogen.sh
./configure --with-tree-sitter --with-native-compilation --without-pop CC=gcc-12
make
sudo make install
