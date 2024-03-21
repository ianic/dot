#!/bin/bash -e

if [[ "$OSTYPE" == "darwin"* ]]; then
    scp ~/.ssh/authorized_keys2 thinkpad:~/.ssh/authorized_keys
    scp ~/.ssh/id_rsa thinkpad:~/.ssh/
    scp ~/.ssh/id_rsa.pub thinkpad:~/.ssh/

    scp ~/code/dot/ubuntu/thinkpad.sh thinkpad:~

    exit 0
fi

if [[ ! -d ~/host/code/dot ]]; then
    mkdir -p ~/host/code
    cd ~/host/code
    git clone git@github.com:ianic/dot.git
else
    cd ~/host/code/dot
    git pull
fi

SCRIPT_DIR=~/.config/dot/ubuntu/
cd $SCRIPT_DIR

if [[ ! -f /etc/sudoers.d/ianic ]]; then
    cd ~
    printf "${CN}sudo without password for ianic${NC}\n"
    echo "ianic ALL=(ALL) NOPASSWD:ALL" >ianic
    sudo mv ianic /etc/sudoers.d/
    sudo chown root:root /etc/sudoers.d/ianic
fi

printf "${CN}install packages ${NC}\n"
sudo apt update -y
sudo apt upgrade -y

sudo -E apt install -y curl net-tools unzip make build-essential \
    zsh git fd-find snapd openssh-server htop tree exa \
    jq bat fzf ripgrep \
    linux-libc-dev liburing-dev cmake \
    linux-tools-common linux-tools-generic linux-tools-$(uname -r) \
    gdb hyperfine emacs-nox acpi lm-sensors

# zsh configuration
if [[ ! -d ~/.oh-my-zsh ]]; then
    printf "${CN}install zsh${NC}\n"
    # set zsh as default shell
    sudo -E usermod --shell /usr/bin/zsh ianic

    git clone https://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
    export ZSH_CUSTOM=~/.oh-my-zsh/custom
    git clone https://github.com/zsh-users/zsh-completions ${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions
    git clone https://github.com/spaceship-prompt/spaceship-prompt.git "$ZSH_CUSTOM/themes/spaceship-prompt" --depth=1
    ln -s "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH_CUSTOM/themes/spaceship.zsh-theme"
fi

if [[ ! -f ~/.zshrc ]]; then
    printf "${CN}link my shell configs${NC}\n"
    cd ~
    ln -s ~/.config/dot/shell/zshrc .zshrc
    ln -s ~/.config/dot/shell/bash_aliases .bash_aliases
    ln -s ~/.config/dot/shell/gitconfig .gitconfig
    ln -s ~/.config/dot/shell/gitignore .gitignore
fi

cd $SCRIPT_DIR
echo install zig
sudo update-ca-certificates
./zig.sh

# experimental
sudo systemctl stop snapd
sudo apt install -y network-manager

curl -LO https://github.com/wez/wezterm/releases/download/nightly/wezterm-nightly.Ubuntu22.04.deb
sudo apt install -y ./wezterm-nightly.Ubuntu22.04.deb
rm wezterm-nightly.Ubuntu22.04.deb

exit 0
# ethernet: 3c:97:0e:46:6b:c7
# wifi:     52:54:00:4c:69:3f

wakeonlan 3c:97:0e:46:6b:c7 && sleep 20 && ssh thinkpad

# show battery
acpi -b

upower --enumerate
upower -i /org/freedesktop/UPower/devices/battery_BAT0

# cpu temperatur and fan speed
watch sensors
