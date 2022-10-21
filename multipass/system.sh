#!/bin/bash -ex

sudo apt-get update -y
sudo apt-get upgrade -y

sudo -E apt-get install -y make build-essential autoconf
sudo -E apt-get install -y curl net-tools unzip htop tree git fd-find jq ripgrep
##sudo -E apt-get install -y zsh emacs-nox
sudo snap refresh emacs --edge --classic
sudo -E snap install go --classic
sudo -E usermod --shell /usr/bin/zsh ubuntu

# Ruby
#sudo -E apt-get install -y ruby-full
#sudo gem install solargraph

cd ~
ln -s ~/code/dot/shell/zshrc        .zshrc
ln -s ~/code/dot/shell/bash_aliases .bash_aliases
ln -s ~/code/dot/shell/gitconfig    .gitconfig
ln -s ~/code/dot/shell/gitignore    .gitignore
mkdir -p ~/src

# zsh
git clone https://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
export ZSH_CUSTOM=~/.oh-my-zsh/custom
git clone https://github.com/zsh-users/zsh-completions ${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions
git clone https://github.com/spaceship-prompt/spaceship-prompt.git "$ZSH_CUSTOM/themes/spaceship-prompt" --depth=1
ln -s "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH_CUSTOM/themes/spaceship.zsh-theme"


# lsd tool
# https://github.com/Peltoche/lsd/releases
cd ~/src
version=0.23.1
wget -q https://github.com/Peltoche/lsd/releases/download/"$version"/lsd_"$version"_arm64.deb
sudo dpkg -i lsd_"$version"_arm64.deb
rm lsd_"$version"_arm64.deb

# # performance monitoring tools
# sudo -E apt-get install -y linux-tools-common linux-tools-generic linux-tools-`uname -r`
# # classic
# cd ~/src
# git clone git@github.com:brendangregg/FlameGraph.git


# #  building perf from source
# cd ~/src
# sudo apt-get install -y flex bison

# sudo apt-get source linux-image-unsigned-$(uname -r)
# cd linux-5.15.0/tools/perf
# make

# # a onda jos za flamegraph: https://github.com/spiermar/d3-flame-graph#input-format
# sudo apt install -y nodejs npm

# ovo mi je trebalo da buildam libressl
# sudo apt-get install -y automake libtool libtool-bin


# skip "The authenticity of host 'github.com can't be established."
# on first git pull
ssh-keyscan github.com >> ~/.ssh/known_hosts
