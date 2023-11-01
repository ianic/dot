#!/bin/bash -ex

sudo apt-get update -y
sudo apt-get upgrade -y

sudo -E apt install -y curl net-tools unzip make build-essential \
    zsh git fd-find snapd openssh-server htop tree exa \
    jq bat fzf ripgrep \
    linux-libc-dev liburing-dev cmake \
    linux-tools-common linux-tools-generic linux-tools-$(uname -r) \
    gdb hyperfine

if [[ ! -d ~/.oh-my-zsh ]]; then
    sudo -E usermod --shell /usr/bin/zsh ubuntu
    cd ~
    ln -s ~/home/code/dot/shell/zshrc .zshrc
    ln -s ~/home/code/dot/shell/bash_aliases .bash_aliases
    ln -s ~/home/code/dot/shell/gitconfig .gitconfig
    ln -s ~/home/code/dot/shell/gitignore .gitignore
    mkdir -p ~/src

    # zsh
    git clone https://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
    export ZSH_CUSTOM=~/.oh-my-zsh/custom
    git clone https://github.com/zsh-users/zsh-completions ${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions
    git clone https://github.com/spaceship-prompt/spaceship-prompt.git "$ZSH_CUSTOM/themes/spaceship-prompt" --depth=1
    ln -s "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH_CUSTOM/themes/spaceship.zsh-theme"
fi

# skip "The authenticity of host 'github.com can't be established."
# on first git pull
ssh-keyscan github.com >>~/.ssh/known_hosts
