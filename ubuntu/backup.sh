#!/bin/bash -e

root=ianic@callisto:/Users/ianic/backups/linux-dev

echo backup ~/zig
rsync -av --delete --exclude zig-out/ --exclude zig-cache/ ~/zig $root

echo backup ~/go
rsync -av --delete --exclude zig-out/ --exclude zig-cache/ --filter=':- .gitignore' ~/go/src $root/go