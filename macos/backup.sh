#!/bin/bash -ex

rsync -av --exclude zig-out/ --exclude zig-cache/ --filter=':- .gitignore' ~/code ~/backups/Callisto
exit 0

wakeonlan 00:08:9B:C9:1E:13
sleep 300

tmutil startbackup --block

while true; do
    if tmutil status | grep "Running = 1;" >>/dev/null; then
        echo timemachine running
        sleep 60
    else
        echo timemachine not running, stopping nas
        /usr/bin/ssh nas poweroff
        exit 0
    fi
done
