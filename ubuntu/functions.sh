#!/bin/bash

# git_clone repo dir
# Dir contains repo name!
# Example:
# git clone https://github.com/zigtools/zls ~/.build/zls
function git_clone() {
    repo=$1
    dir=$2

    if [[ ! -d $dir ]]; then
        mkdir -p $dir
        cd $dir
        git clone $repo .
    else
        cd $dir
        git pull
    fi
}

# link ~/.config/dot/shell/bash_aliases ~/.bash_aliases
# make both path absolute
function link() {
    echo ln -s $1 to $2
    mkdir -p $(dirname $2)
    rm -rf $2
    ln -s $1 $2
}
