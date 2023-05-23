#!/bin/bash -ex

brew tap d12frosted/emacs-plus
brew install emacs-plus@29 --with-native-comp

# add this emacs to the path
echo $PATH=/opt/homebrew/opt/emacs-plus@29/bin:$PATH

# so it is used by doom
doom syn

# link emacs to the applications
ln -s /opt/homebrew/opt/emacs-plus@29/Emacs.app /Applications

# link emacs and emacsclient
rm  /opt/homebrew/bin/emacs
rm  /opt/homebrew/bin/emacsclient

ln -s /opt/homebrew/opt/emacs-plus@29/bin/emacsclient /opt/homebrew/bin/
ln -s /opt/homebrew/opt/emacs-plus@29/bin/emacs /opt/homebrew/bin/

# start emacs deamon
brew services restart d12frosted/emacs-plus/emacs-plus@29
# start emacs with:
# emacsclient -nc


# Notes
# for https://emacsformacosx.com version this are needed paths:
#
#  ln -s /Applications/Emacs.app/Contents/MacOS/Emacs /opt/homebrew/bin/emacs
#  ln -s /Applications/Emacs.app/Contents/MacOS/bin-arm64-11/emacsclient /opt/homebrew/bin/emacsclient
