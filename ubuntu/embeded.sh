#!/bin/bash -ex

# for working with st
sudo apt-get install -y stlink-tools
#sudo apt-get -y install gcc-arm-none-eabi # this one don't have gdb!!!

# make it version configuriable
if [ ! -d /usr/local/arm-gnu-toolchain/arm-gnu-toolchain-12.2.mpacbti-bet1-aarch64-arm-none-eabi ]; then
  #arm developer tools
  #ref: https://developer.arm.com/downloads/-/arm-gnu-toolchain-downloads
  cd ~/src
  wget https://developer.arm.com/-/media/Files/downloads/gnu/12.2.mpacbti-bet1/binrel/arm-gnu-toolchain-12.2.mpacbti-bet1-aarch64-arm-none-eabi.tar.xz
  tar -xf arm-gnu-toolchain-12.2.mpacbti-bet1-aarch64-arm-none-eabi.tar.xz
  sudo mkdir -p /usr/local/arm-gnu-toolchain
  sudo mv arm-gnu-toolchain-12.2.mpacbti-bet1-aarch64-arm-none-eabi /usr/local/arm-gnu-toolchain

  sudo rm /usr/local/bin/arm-none-eabi-*
  sudo ln -s /usr/local/arm-gnu-toolchain/arm-gnu-toolchain-12.2.mpacbti-bet1-aarch64-arm-none-eabi/bin/arm-none-eabi-* /usr/local/bin

  # build python 3.8 required by gdb
  # ref: https://community.arm.com/support-forums/f/compilers-and-libraries-forum/52805/gcc-arm-11-2-2022-02-x86_64-arm-none-eabi-gdb-fails-on-ubuntu
  cd ~/src
  git clone https://github.com/deadsnakes/python3.8
  cd python3.8
  sudo apt install -y zlib1g-dev libc6-dev libexpat1-dev libssl-dev libbz2-dev \
                   libffi-dev libdb-dev liblzma-dev libncurses-dev \
                   libncursesw5-dev libsqlite3-dev libreadline-dev uuid-dev \
                   libgdbm-dev tk-dev libbluetooth-dev build-essential
  CXX="/usr/bin/g++" ./configure --prefix=/usr/local \\n                               --with-system-expat \\n                               --with-system-ffi \\n                               --with-ensurepip=install \\n                               --enable-shared
  make
  sudo make altinstall
  cd /usr/lib/aarch64-linux-gnu
  sudo ln -s /usr/local/lib/libpython3.8.so.1.0
fi

if [ ! -f /usr/local/bin/blackmagic ]; then
  # blackmagic
  cd ~/src
  git clone https://github.com/blackmagic-debug/blackmagic
  cd blackmagic
  make PROBE_HOST=hosted HOSTED_BMP_ONLY=1
  sudo mv src/blackmagic /usr/local/bin
fi

if [ -f .local/bin/svd ]; then
  # install svd tools, need python pip for that
  cd ~/src
  wget https://bootstrap.pypa.io/get-pip.py
  python3 get-pip.py
  export PATH=$PATH:~/.local/bin
  pip install --user svdtools
fi
