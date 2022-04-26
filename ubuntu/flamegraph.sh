#!/usr/bin/env bash

export LC_ALL="en_US.UTF-8"
dir=~/code/flamegraph
mkdir -p "$dir"
cd "$dir"

sudo perf record -F 99 -a -g -- sleep 20
sudo chown ubuntu:ubuntu perf.data

ts=$(date +%Y-%m-%dT%H-%M-%S)
perf script --header > "$ts.out"
cd ~/src/FlameGraph
./stackcollapse-perf.pl < "$dir/$ts.out" | ./flamegraph.pl --hash > "$dir/$ts.svg"
echo "created: $dir/$ts.svg"
