#!/bin/bash -ex

sudo apt-get update -y
sudo apt-get upgrade -y

sudo -E apt-get install -y  curl net-tools unzip make build-essential jq zsh git ripgrep fd-find snapd openssh-server htop tree
sudo -E apt-get install -y sway
sudo -E apt-get install -y i3 rofi dzen2

sudo -E snap install go --classic
sudo -E snap install emacs --classic
sudo -E usermod --shell /usr/bin/zsh ianic

# Ruby
#sudo -E apt-get install -y  ruby-full
#sudo gem install  solargraph


