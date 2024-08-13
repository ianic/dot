#!/bin/bash -e

root=ianic@callisto:/Users/ianic/backups/linux/$(hostname)

echo backup ~/Code
rsync -rlptiv --delete \
    --exclude zig-out \
    --exclude zig-cache \
    --exclude .zig-cache \
    --exclude build \
    --exclude zig-global-cache-master \
    --exclude zig-global-cache-release \
    ~/Code $root

#echo backup ~/go
#rsync -av --delete --exclude zig-out/ --exclude zig-cache/ --filter=':- .gitignore' ~/go/src $root/go
