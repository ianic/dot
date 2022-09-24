#!/bin/bash -ex

cd ~/code/

# get builder source
if [ -d build-emacs-for-macos ]; then
    cd build-emacs-for-macos
    #git pull
else
   git clone https://github.com/jimeh/build-emacs-for-macos
   cd build-emacs-for-macos
   brew bundle
fi

#./build-emacs-for-macos emacs-28
./build-emacs-for-macos master

cd builds
# extract archive
archive=$(basename $(ls -t *.tbz | head -1))
tar -xvjf $archive

# sign
folder="${archive%.*}"
go run ../cmd/emacs-builder sign --sign - $folder/Emacs.app

# remove symlink
if [ -L /Applications/Emacs.app ]; then
    rm /Applications/Emacs.app
fi
# or rename dir
if [ -d /Applications/Emacs.app ]; then
    current=$(/Applications/Emacs.app/Contents/MacOS/Emacs --version | head -n 1 | cut -d " " -f 3)
    mv /Applications/Emacs.app /Applications/Emacs_$current.app
fi

# symlink this version
ln -s $(pwd)/$folder/Emacs.app /Applications
# mv $folder/Emacs.app /Applications

# rebuild doom packages
~/.emacs.d/bin/doom sync


# notes:
# start emacs daemon:
#$ launchctl start gnu.emacs.daemon
# stop emacs daemon
#$ emacsclient -e '(kill-emacs)'
# open emacs frame:
#$ oe
# which is alias to:
#$ emacsclient -c -n -a /Applications/Emacs.app/Contents/MacOS/Emacs
