#!/bin/bash -ex

# install gcc 12
# ref: https://www.linuxcapable.com/how-to-install-gcc-compiler-on-ubuntu-22-04-lts/
sudo add-apt-repository ppa:ubuntu-toolchain-r/test -y
sudo apt update && sudo apt upgrade
sudo apt install -y build-essential
sudo apt install -y g++-12 gcc-12
sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-12 100 --slave /usr/bin/g++ g++ /usr/bin/g++-12 --slave /usr/bin/gcov gcov /usr/bin/gcov-12
sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-11 80 --slave /usr/bin/g++ g++ /usr/bin/g++-11 --slave /usr/bin/gcov gcov /usr/bin/gcov-11

# trying to fix zig-bootstrap build
sudo apt install -y libatomic-ops-dev
