#!/bin/sh -e

sudo apt-get update -y
sudo apt-get upgrade -y

sudo -E apt-get install -y curl net-tools unzip make build-essential jq zsh
sudo -E snap install emacs go --classic
sudo -E snap install tree

sudo -E usermod --shell /usr/bin/zsh ubuntu

cd ~
ln -s ~/code/dot/shell/zshrc        .zshrc
ln -s ~/code/dot/shell/bash_aliases .bash_aliases

# zsh
git clone https://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
export ZSH_CUSTOM="~/.oh-my-zsh/custom"
git clone https://github.com/zsh-users/zsh-completions ${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions
git clone https://github.com/spaceship-prompt/spaceship-prompt.git "$ZSH_CUSTOM/themes/spaceship-prompt" --depth=1
ln -s "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH_CUSTOM/themes/spaceship.zsh-theme"


# doom emacs
# cd ~
# ln -s ~/code/dot/doom.d             .doom.d
# git clone --depth 1 https://github.com/hlissner/doom-emacs ~/.emacs.d
# ~/.emacs.d/bin/doom install
