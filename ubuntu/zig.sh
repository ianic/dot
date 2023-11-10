#!/bin/bash -e

#installs zig into /usr/local/bin
#works for Linux and macOS arm machines

arch=linux
if [[ "$OSTYPE" == "darwin"* ]]; then
    arch=macos
fi

# echo "before zig version: $(zig version)"

stable_version=0.11.0
stable=$(curl -s https://ziglang.org/download/index.json | jq ".\"$stable_version\".\"aarch64-$arch\".tarball" -r)
# find the latest build
latest=$(curl -s https://ziglang.org/download/index.json | jq ".master.\"aarch64-$arch\".tarball" -r)

urls=("$stable" "$latest")
for url in "${urls[@]}"; do
    fn=$(basename $url)
    dir=${fn%.tar.xz}
    if [[ ! -d /usr/local/zig/$dir ]]; then
        wget $url
        tar xvf $fn
        sudo mkdir -p /usr/local/zig
        sudo mv $dir /usr/local/zig
        sudo rm -f /usr/local/bin/zig
        sudo ln -s /usr/local/zig/$dir/zig /usr/local/bin/
        rm -f $fn
    fi
done

# zls install from source
build_root=~/.build
cd ~ && mkdir -p $build_root && cd $build_root
if [[ ! -d $build_root/zls ]]; then
    git clone --recurse-submodules https://github.com/zigtools/zls
    cd zls
else
    cd zls
    git pull
fi
zig build -Doptimize=ReleaseSafe

mkdir -p ~/.local/bin
rm ~/.local/bin/zls || true
cp ./zig-out/bin/zls ~/.local/bin
# ovo je interactive
# ./zig-out/bin/zls config # Configure ZLS
# [[ -f ~/zls.json ]] || echo '{"zig_exe_path":"/usr/local/bin/zig","enable_snippets":true,"warn_style":true,"enable_semantic_tokens":true,"operator_completions":true,"include_at_in_builtins":false,"max_detail_length":1048576}' > ~/zls.json

echo "after zig version: $(zig version)"
