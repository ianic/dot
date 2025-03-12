#!/bin/bash

pattern="https://github.com/.*/archive/"
grep "^\s*.url =" build.zig.zon | while IFS= read -r line; do
    # echo "Processing: $line"
    if [[ "$line" =~ $pattern ]]; then
        prefix=$BASH_REMATCH

        repo="${prefix::-9}"
        echo repo: $repo
        commit=$(git ls-remote $repo.git HEAD | awk '{print $1}')
        url="$prefix$commit.tar.gz"
        echo "upgrade to: $url"
        zig fetch --save $url
    else
        echo "failed to process line: $line"
    fi
done
