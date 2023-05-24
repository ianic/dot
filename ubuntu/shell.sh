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
    wget -q https://github.com/Peltoche/lsd/releases/download/0.23.1/lsd_0.23.1_arm64.deb
    sudo dpkg -i lsd_0.23.1_arm64.deb
    rm lsd_0.23.1_arm64.deb

    # disable screen lock
    gsettings set org.gnome.desktop.screensaver lock-enabled false
fi

if [[ ! -f ~/.zshrc ]]; then
    echo "link my shell configs"
    cd ~
    ln -s ~/host/code/dot/shell/zshrc        .zshrc
    ln -s ~/host/code/dot/shell/bash_aliases .bash_aliases
    ln -s ~/host/code/dot/shell/gitconfig    .gitconfig
    ln -s ~/host/code/dot/shell/gitignore    .gitignore

    mkdir -p ~/.config/i3
    ln -s ~/host/code/dot/ubuntu/i3 ~/.config/i3/config

    mkdir -p ~/.config/rofi
    ln -s ~/host/code/dot/ubuntu/rofi ~/.config/rofi/config.rasi
    #mkdir -p ~/.config/i3status
    #ln -s /home/ianic/code/dot/ubuntu/i3status ~/.config/i3status/config
fi

if [[ ! -d ~/.fonts ]]; then
    echo "install fonts"
    cd ~
    version=v3.0.1
    wget https://github.com/ryanoasis/nerd-fonts/releases/download/$version/UbuntuMono.zip
    wget https://github.com/ryanoasis/nerd-fonts/releases/download/$version/Hack.zip
    wget https://github.com/ryanoasis/nerd-fonts/releases/download/$version/Meslo.zip
    wget https://github.com/ryanoasis/nerd-fonts/releases/download/$version/SourceCodePro.zip
    wget https://github.com/ryanoasis/nerd-fonts/releases/download/$version/JetBrainsMono.zip

    unzip -o SourceCodePro.zip -d ~/.fonts
    unzip -o UbuntuMono.zip -d ~/.fonts
    unzip -o Hack.zip -d ~/.fonts
    unzip -o Meslo.zip -d ~/.fonts
    unzip -o JetBrainsMono.zip -d ~/.fonts
    rm -f UbuntuMono.zip Hack.zip Meslo.zip SourceCodePro.zip JetBrainsMono.zip

    fc-cache -fv

    sudo apt install fonts-firacode

    # iosevka fonts how to install:
    # https://blog.programster.org/install-iosevka-fonts
fi
