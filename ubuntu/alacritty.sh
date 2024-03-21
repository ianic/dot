#!/bin/bash -ex
# ref: https://github.com/alacritty/alacritty/blob/master/INSTALL.md#install-the-rust-compiler-with-rustup
# https://rustup.rs

if [ ! -f /usr/local/bin/alacritty ]; then
  sudo apt-get install -y cmake pkg-config libfreetype6-dev libfontconfig1-dev libxcb-xfixes0-dev libxkbcommon-dev python3

  # install rustup
  #curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- --default-toolchain stable -y
  export PATH=$PATH:$HOME/.cargo/bin

  # and rust stable
  rustup override set stable
  rustup update stable

  # get alacritty code and build
  mkdir -p ~/src
  cd ~/src
  if [[ -d alacritty ]]; then
      cd alacritty
      git pull
  else
      git clone https://github.com/alacritty/alacritty.git
      cd alacritty
  fi
  cargo build --release

  # move binary to path
  cd target/release
  sudo mv alacritty /usr/local/bin || true

  # add zsh completions
  mkdir -p ~/.oh-my-zsh/functions
  cp ~/src/alacritty/extra/completions/_alacritty ~/.oh-my-zsh/functions


  cd ~
  if [[ ! -f .alacritty.yml ]]; then
      ln -s ~/.config/dot/ubuntu/alacritty.yml .alacritty.yml
  fi
fi
