#!/bin/bash -ex

if [[ ! -d ~/.oh-my-zsh ]]; then
    echo "install zsh"
    git clone https://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
    export ZSH_CUSTOM=~/.oh-my-zsh/custom
    git clone https://github.com/zsh-users/zsh-completions ${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions
    git clone https://github.com/spaceship-prompt/spaceship-prompt.git "$ZSH_CUSTOM/themes/spaceship-prompt" --depth=1
    ln -s "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH_CUSTOM/themes/spaceship.zsh-theme"

    echo "install lsd tool"
    # https://github.com/Peltoche/lsd/releases
    wget -q https://github.com/Peltoche/lsd/releases/download/0.21.0/lsd_0.21.0_arm64.deb
    sudo dpkg -i lsd_0.21.0_arm64.deb
    rm lsd_0.21.0_arm64.deb

    # disable screen lock
    gsettings set org.gnome.desktop.screensaver lock-enabled false
fi

if [[ ! -f ~/.zshrc ]]; then
    echo "link my shell configs"
    cd ~
    ln -s ~/code/dot/shell/zshrc        .zshrc
    ln -s ~/code/dot/shell/bash_aliases .bash_aliases
    ln -s ~/code/dot/shell/gitconfig    .gitconfig
    ln -s ~/code/dot/shell/gitignore    .gitignore

    mkdir -p ~/.config/i3
    ln -s ~/code/dot/ubuntu/i3 ~/.config/i3/config

    mkdir -p ~/.config/i3status
    ln -s /home/ianic/code/dot/ubuntu/i3status ~/.config/i3status/config
fi

if [[ ! -d ~/.fonts ]]; then
    echo "install fonts"
    cd ~
    wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/UbuntuMono.zip
    wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/Hack.zip
    wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/Meslo.zip
    wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/SourceCodePro.zip

    unzip SourceCodePro.zip -d ~/.fonts
    unzip UbuntuMono.zip -d ~/.fonts
    unzip Hack.zip -d ~/.fonts
    unzip Meslo.zip -d ~/.fonts
    fc-cache -fv
    rm -f UbuntuMono.zip Hack.zip Meslo.zip SourceCodePro.zip

    sudo apt install fonts-firacode
fi
