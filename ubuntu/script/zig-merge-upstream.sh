#! /bin/bash -e

cd ~/Code/zig
git fetch upstream
git checkout master
git merge upstream/master
git push origin master
