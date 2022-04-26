#!/bin/bash -ex

sudo apt-get update -y
sudo apt-get upgrade -y

sudo -E apt-get install -y curl net-tools unzip make build-essential jq zsh
sudo -E snap install emacs --classic
sudo -E snap install go --classic
sudo -E snap install tree

sudo -E usermod --shell /usr/bin/zsh ubuntu

cd ~
ln -s ~/code/dot/shell/zshrc        .zshrc
ln -s ~/code/dot/shell/bash_aliases .bash_aliases
ln -s ~/code/dot/shell/gitconfig    .gitconfig
ln -s ~/code/dot/shell/gitignore    .gitignore

# zsh
git clone https://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
export ZSH_CUSTOM=~/.oh-my-zsh/custom
git clone https://github.com/zsh-users/zsh-completions ${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions
git clone https://github.com/spaceship-prompt/spaceship-prompt.git "$ZSH_CUSTOM/themes/spaceship-prompt" --depth=1
ln -s "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH_CUSTOM/themes/spaceship.zsh-theme"


# doom emacs
# cd ~
# ln -s ~/code/dot/doom.d             .doom.d
# git clone --depth 1 https://github.com/hlissner/doom-emacs ~/.emacs.d
# ~/.emacs.d/bin/doom install

# lsd tool
# https://github.com/Peltoche/lsd/releases
wget -q https://github.com/Peltoche/lsd/releases/download/0.21.0/lsd_0.21.0_arm64.deb
sudo dpkg -i lsd_0.21.0_arm64.deb
rm lsd_0.21.0_arm64.deb

# performance monitoring tools
sudo -E apt-get install -y linux-tools-common linux-tools-generic linux-tools-`uname -r`

# classis
cd ~/src
git clone git@github.com:brendangregg/FlameGraph.git


# #  building perf from source
# cd ~/src
# sudo apt-get install -y flex bison

# sudo apt-get source linux-image-unsigned-$(uname -r)
# cd linux-5.15.0/tools/perf
# make

# # a onda jos za flamegraph: https://github.com/spiermar/d3-flame-graph#input-format
# sudo apt install -y nodejs npm
