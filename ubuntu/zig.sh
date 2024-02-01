#!/bin/bash -e

#installs zig into /usr/local/bin
#works for Linux and macOS arm machines

os=linux
[[ "$OSTYPE" == "darwin"* ]] && os=macos
arch=aarch64-$os
arch | grep x86_64 >>/dev/null && arch=x86_64-$os

stable_version=0.11.0
stable=$(curl -s https://ziglang.org/download/index.json | jq ".\"$stable_version\".\"$arch\".tarball" -r)
# find the latest build
latest=$(curl -s https://ziglang.org/download/index.json | jq ".master.\"$arch\".tarball" -r)

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

# run test on different platforms
# zig test  lib/std/std.zig  --zig-lib-dir lib --main-mod-path lib/std  -target wasm32-wasi    --test-cmd wasmtime         --test-cmd-bin         --test-filter "tar "
# zig test  lib/std/std.zig  --zig-lib-dir lib --main-mod-path lib/std  -target x86-linux-none --test-cmd qemu-i386-static --test-cmd-bin         --test-filter "tar "
# zig test  lib/std/std.zig  --zig-lib-dir lib --main-mod-path lib/std  -target x86-linux-gnu  --test-cmd qemu-i386-static --test-cmd-bin         --test-filter "tar "
# zig test  lib/std/std.zig  --zig-lib-dir lib --main-mod-path lib/std  -target x86-linux-musl --test-cmd qemu-i386-static --test-cmd-bin         --test-filter "tar "
# zig test  lib/std/std.zig  --zig-lib-dir lib --main-mod-path lib/std  -target powerpc-linux-none --test-cmd qemu-powerpc-static --test-cmd-bin  --test-filter "tar "
# zig test  lib/std/std.zig  --zig-lib-dir lib --main-mod-path lib/std  -target powerpc-linux-musl --test-cmd qemu-powerpc-static --test-cmd-bin  --test-filter "tar "
# zig test  lib/std/std.zig  --zig-lib-dir lib --main-mod-path lib/std  -target arm-linux-musleabihf --test-cmd qemu-arm-static   --test-cmd-bin  --test-filter "tar "
# zig test  lib/std/std.zig  --zig-lib-dir lib --main-mod-path lib/std  -target arm-linux-none       --test-cmd qemu-arm-static   --test-cmd-bin  --test-filter "tar "
#
