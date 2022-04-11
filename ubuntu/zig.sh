#!/bin/bash -ex

# zig 0.9.1
wget https://ziglang.org/download/0.9.1/zig-linux-aarch64-0.9.1.tar.xz
tar xvf zig-linux-aarch64-0.9.1.tar.xz
sudo mv zig-linux-aarch64-0.9.1 /usr/local/bin
sudo ln -s /usr/local/bin/zig-linux-aarch64-0.9.1/zig /usr/local/bin/
rm zig-linux-aarch64-0.9.1.tar.xz

# zig master
# https://ziglang.org/download/
zig_version=zig-linux-aarch64-0.10.0-dev.1740+971ef7b9c
wget https://ziglang.org/builds/$zig_version.tar.xz
tar xvf $zig_version.tar.xz
sudo mv $zig_version /usr/local/bin
sudo rm /usr/local/bin/zig
sudo ln -s /usr/local/bin/$zig_version/zig /usr/local/bin/
rm $zig_version.tar.xz

# zls install from source
cd ~
mkdir -p src
cd src
git clone --recurse-submodules https://github.com/zigtools/zls
cd zls
zig build -Drelease-safe
# ovo je interactive
# ./zig-out/bin/zls config # Configure ZLS
# kreira file: /etc/zls.json
# {"zig_exe_path":"/usr/local/bin/zig","enable_snippets":true,"warn_style":true,"enable_semantic_tokens":true,"operator_completions":true,"include_at_in_builtins":false,"max_detail_length":1048576}
sudo cp ./zig-out/bin/zls /usr/local/bin/
echo '{"zig_exe_path":"/usr/local/bin/zig","enable_snippets":true,"warn_style":true,"enable_semantic_tokens":true,"operator_completions":true,"include_at_in_builtins":false,"max_detail_length":1048576}' > ~/zls.json
sudo mv ~/zls.json /etc/zls.json
