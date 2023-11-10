#!/bin/bash -ex

rsync -avO --delete --exclude zig-tmp/ --exclude zig-out/ --exclude zig-cache/ --filter=':- .gitignore' ~/code ~/backups/Callisto
