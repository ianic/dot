#! /bin/bash -e

current_branch=$(git branch --show-current)

cd ~/Code/zig
git fetch upstream
git checkout master
git merge upstream/master
git push origin master

git checkout $current_branch
git rebase master
# git push -f


read -p "push -f (y/n)?" choice
case "$choice" in
  y|Y )
      git push -f
      ;;
  n|N ) ;;
  * ) ;;
esac
