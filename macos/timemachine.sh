#!/bin/bash -e

exclude_folders() {
    for f in $(find . -type d -name $1); do
        if tmutil isexcluded $f | grep Excluded >/dev/null; then
            echo "already excluded: $f"
            #tmutil removeexclusion $f
        else
            echo "excluding: $f"
            tmutil addexclusion $f
        fi
    done
}

cd ~/code
exclude_folders zig-cache
exclude_folders zig-out

cd ~/zig
exclude_folders zig-cache
exclude_folders zig-out

cd ~/src
exclude_folders zig-cache
exclude_folders zig-out

# notes
# defaults read /Library/Preferences/com.apple.TimeMachine SkipPaths
#
