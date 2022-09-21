#!/bin/bash -ex
#
#Ref: https://www.epmor.app/posts/building-zig-from-scratch

brew install cmake

# ninja build from source
git clone git@github.com:ninja-build/ninja.git
cd ninja
cmake -Bbuild-cmake
cmake --build build-cmake
export PATH=$PATH:$(pwd)/build-cmake
ninja --version
cd ..

git clone https://github.com/llvm/llvm-project
cd llvm-project
git checkout llvmorg-15.0.0
cmake -G Ninja -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=/opt/llvm-macos13.0-arm64-15.0.0-release -DLLVM_PARALLEL_LINK_JOBS=1 -DLLVM_ENABLE_PROJECTS='clang;lld' -DLLVM_ENABLE_PLUGINS=OFF -DLLVM_ENABLE_LIBXML2=OFF -DLLVM_ENABLE_TERMINFO=OFF -DLLVM_INCLUDE_TESTS=OFF -S ./llvm -B _build.llvm-macos13.0-arm64-15.0.0-release
ninja -C _build.llvm-macos13.0-arm64-15.0.0-release
sudo ninja install -C _build.llvm-macos13.0-arm64-15.0.0-release
export PATH=$PATH:/opt/llvm-macos13.0-arm64-15.0.0-release
cd  ..

git clone https://github.com/ziglang/zig
cd zig
cmake -G Ninja -B stage3 -DCMAKE_PREFIX_PATH=/opt/llvm-macos13.0-arm64-15.0.0-release
cd stage3
ninja
stage3/bin/zig version


# sudo rm -rf /opt/llvm-macos13.0-arm64-15.0.0-release/
