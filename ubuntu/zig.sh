#!/bin/bash -ex

#installs zig into /usr/local/bin
#works for Linux and macOS arm machines

arch=linux
if [[ "$OSTYPE" == "darwin"* ]]; then
    arch=macos
fi

echo "before zig version: $(zig version)"

stable=https://ziglang.org/download/0.10.0/zig-$arch-aarch64-0.10.0.tar.xz
# find the latest build
latest=$(curl -s https://ziglang.org/download/index.json | jq ".master.\"aarch64-$arch\".tarball" -r)

# latest known good before stage1 changes
# latest="https://ziglang.org/builds/zig-linux-aarch64-0.10.0-dev.3475+b3d463c9e.tar.xz"

urls=( "$stable" "$latest" )
# urls=( "$latest" )
for url in "${urls[@]}"; do
  fn=$(basename $url)
  dir=${fn%.tar.xz}
  if [[ ! -d /usr/local/zig/$dir ]]; then
      wget $url
      tar xvf $fn
      sudo mkdir -p /usr/local/zig
      sudo mv $dir  /usr/local/zig
      sudo rm -f /usr/local/bin/zig
      sudo ln -s /usr/local/zig/$dir/zig /usr/local/bin/
      rm -f $fn
  fi
done

# zls install from source
cd ~ && mkdir -p src && cd src
if [[ ! -d ~/src/zls ]]; then
    git clone --recurse-submodules https://github.com/zigtools/zls
    cd zls
else
    cd zls
    git pull
fi
zig build -Drelease-safe
sudo rm /usr/local/bin/zls || true
sudo cp ./zig-out/bin/zls /usr/local/bin/
# ovo je interactive
# ./zig-out/bin/zls config # Configure ZLS
[[ -f ~/zls.json ]] || echo '{"zig_exe_path":"/usr/local/bin/zig","enable_snippets":true,"warn_style":true,"enable_semantic_tokens":true,"operator_completions":true,"include_at_in_builtins":false,"max_detail_length":1048576}' > ~/zls.json

echo "after zig version: $(zig version)"
