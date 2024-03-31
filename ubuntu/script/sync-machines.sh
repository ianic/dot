#!/bin/bash -ex

echo macOS

rsync -rlpDi  \
    --exclude zig-cache --exclude zig-out \
    --exclude build --exclude .git \
    --exclude tmp --exclude .DS_Store \
    ~/Code/zig/ callisto:/Users/ianic/code/$(hostname)/zig

rsync -rlpDi \
    --exclude zig-cache --exclude zig-out \
    --exclude build --exclude .git \
    --exclude tmp --exclude .DS_Store \
    --exclude zig-global-cache-master \
    --exclude zig-global-cache-release \
    ~/Code/zig-fetch-test/ callisto:/Users/ianic/code/$(hostname)/zig-fetch-test




# echo Windows

# sudo mount -t cifs -o username=ianic,dir_mode=0777,file_mode=0777 //172.16.145.128/Users/igora/Code /media/win_code || true

# # # sudo mount -t cifs -o username=ianic,dir_mode=0777,file_mode=0777 //10.211.55.27/code /media/win_code

# rsync -ri \
#     --exclude zig-cache --exclude zig-out \
#     --exclude build --exclude .git \
#     --exclude tmp --exclude .DS_Store \
#     --exclude zig-global-cache-master \
#     --exclude zig-global-cache-release \
#     --exclude sample\ \
#     ~/Code/zig-fetch-test/ /media/win_code/zig-fetch-test

# rsync -ri \
#     --exclude zig-cache --exclude zig-out \
#     --exclude build --exclude .git \
#     --exclude tmp --exclude .DS_Store \
#     ~/Code/zig/ /media/win_code/zig
=



# --exclude zig-cache --exclude zig-out --exclude build --exclude .git --exclude tmp --exclude .DS_Store \



# # rsync -rDvzv --exclude zig-global-cache-release --exclude zig-global-cache-master --exclude zig-cache --exclude zig-out  ~/zig/issues/fetch/ /media/win_code/issues/fetch
