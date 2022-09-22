#!/bin/bash -ex
#
#Ref: https://www.epmor.app/posts/building-zig-from-scratch

if [[ $(brew list | grep -E "ninja|cmake" -c) != 2 ]]; then
    brew install cmake ninja
fi

build_name=llvm-macos$(sw_vers -productVersion)-arm64-15.0.0-release
llvm_install_dir=$(pwd)/$build_name

if [ ! -d $llvm_install_dir ]; then
   if [ ! -d llvm-project ]; then
       git clone https://github.com/llvm/llvm-project
       cd llvm-project
       git checkout llvmorg-15.0.0
   else
       cd llvm-project
   fi
   cmake -G Ninja -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=$llvm_install_dir -DLLVM_PARALLEL_LINK_JOBS=8 -DLLVM_ENABLE_PROJECTS='clang;lld' -DLLVM_ENABLE_PLUGINS=OFF -DLLVM_ENABLE_LIBXML2=OFF -DLLVM_ENABLE_TERMINFO=OFF -DLLVM_INCLUDE_TESTS=OFF -S ./llvm -B _build.$build_name
   ninja -C _build.$build_name
   ninja install -C _build.$build_name
   cd  ..
fi

zig_build() {
    cmake -G Ninja -B stage3 -DCMAKE_PREFIX_PATH=$llvm_install_dir
    cd stage3
    ninja

    echo "#(pwd)stage3/bin/zig"
    stage3/bin/zig version
}

if [ ! -d zig ]; then
    git clone https://github.com/ziglang/zig
    cd zig
    zig_build
else
    cd zig
    git fetch
    if git diff --exit-code master origin/master; then
        echo "already up to date"
    else
        git pull
        zig_build
    fi
fi


# notes:
# xcrun --show-sdk-version
# xcrun --show-sdk-path
# clang --version
# system_profiler SPSoftwareDataType
# sw_vers -productVersion
