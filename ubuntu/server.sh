SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)

if [[ ! -d ~/host ]]; then
    cd ~
    ln -s /media/psf/Home/ host
    ln -s /media/psf/Home/code code
fi

cd $SCRIPT_DIR

if [[ ! -f ~/.ssh/id_rsa ]]; then
    echo "copy my ssh keys"
    cd ~
    mkdir -p .ssh
    cd .ssh
    cp ~/host/.ssh/authorized_keys2 .
    cp ~/host/.ssh/id_rsa .
    cp ~/host/.ssh/id_rsa.pub .
fi

if [[ ! -f /etc/sudoers.d/ianic ]]; then
    cd ~
    echo "sudo without password for ianic"
    echo "ianic ALL=(ALL) NOPASSWD:ALL" >ianic
    sudo mv ianic /etc/sudoers.d/
    sudo chown root:root /etc/sudoers.d/ianic
fi

echo "install packages"
sudo apt update -y
sudo apt upgrade -y

sudo -E apt install -y curl net-tools unzip make build-essential \
    zsh git fd-find snapd openssh-server htop tree exa \
    jq bat fzf ripgrep \
    linux-libc-dev liburing-dev cmake \
    linux-tools-common linux-tools-generic linux-tools-$(uname -r) \
    gdb hyperfine

# set zsh as default shell
sudo -E usermod --shell /usr/bin/zsh ianic
# zsh configuration
if [[ ! -d ~/.oh-my-zsh ]]; then
    echo "install zsh"
    git clone https://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
    export ZSH_CUSTOM=~/.oh-my-zsh/custom
    git clone https://github.com/zsh-users/zsh-completions ${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions
    git clone https://github.com/spaceship-prompt/spaceship-prompt.git "$ZSH_CUSTOM/themes/spaceship-prompt" --depth=1
    ln -s "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH_CUSTOM/themes/spaceship.zsh-theme"
fi

if [[ ! -f ~/.zshrc ]]; then
    echo "link my shell configs"
    cd ~
    ln -s ~/host/code/dot/shell/zshrc .zshrc
    ln -s ~/host/code/dot/shell/bash_aliases .bash_aliases
    ln -s ~/host/code/dot/shell/gitconfig .gitconfig
    ln -s ~/host/code/dot/shell/gitignore .gitignore
fi

cd $SCRIPT_DIR
sudo update-ca-certificates
./zig.sh

# install websocat from github release
# https://github.com/vi/websocat/releases
wget https://github.com/vi/websocat/releases/download/v1.11.0/websocat.aarch64-unknown-linux-musl &&
    mv websocat.aarch64-unknown-linux-musl ~/.local/bin/websocat &&
    chmod +x ~/.local/bin/websocat

# Go install
wget https://go.dev/dl/go1.21.0.linux-arm64.tar.gz
sudo rm -rf /usr/local/go && sudo tar -C /usr/local -xzf go1.21.0.linux-arm64.tar.gz
go version
rm go1.21.0.linux-arm64.tar.gz
