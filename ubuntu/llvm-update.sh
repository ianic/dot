#!/bin/bash
# add clang ${version} to Ubuntu

update_alternatives() {
    local version=${1}
    local priority=${2}
    local master=${3}
    local slaves=${4}
    local path=${5}
    local cmdln

    cmdln="--verbose --install ${path}${master} ${master} ${path}${master}-${version} ${priority}"
    for slave in ${slaves}; do
        cmdln="${cmdln} --slave ${path}${slave} ${slave} ${path}${slave}-${version}"
    done
    sudo update-alternatives ${cmdln}
}


if [[ ${#} -ne 2 ]]; then
    echo usage: "${0}" clang_version priority
    exit 1
fi

# reference:
# https://apt.llvm.org

# # LLVM
# sudo apt install -y libllvm-17-ocaml-dev libllvm17 llvm-17 llvm-17-dev \
# llvm-17-doc llvm-17-examples llvm-17-runtime
# # Clang and co
# sudo apt install clang-17 clang-tools-17 clang-17-doc \
# libclang-common-17-dev libclang-17-dev libclang1-17 clang-format-17 \
# python3-clang-17 clangd-17 clang-tidy-17

version=${1}
priority=${2}
path="/usr/bin/"

sudo apt update

rm llvm.sh
# download and launch the setup script
wget https://apt.llvm.org/llvm.sh
sudo bash llvm.sh ${version} all

# configure with update-alternatives
master="llvm-config"
slaves="llvm-addr2line llvm-ar llvm-as llvm-bcanalyzer llvm-bitcode-strip
llvm-cat llvm-cfi-verify llvm-cov llvm-c-test llvm-cvtres llvm-cxxdump
llvm-cxxfilt llvm-cxxmap llvm-debuginfo-analyzer llvm-debuginfod
llvm-debuginfod-find llvm-diff llvm-dis llvm-dlltool llvm-dwarfdump
llvm-dwarfutil llvm-dwp llvm-exegesis llvm-extract llvm-gsymutil llvm-ifs
llvm-install-name-tool llvm-jitlink llvm-jitlink-executor llvm-lib
llvm-libtool-darwin llvm-link llvm-lipo llvm-lto llvm-lto2 llvm-mc llvm-mca
llvm-ml llvm-modextract llvm-mt llvm-nm llvm-objcopy llvm-objdump
llvm-omp-device-info llvm-omp-kernel-replay llvm-opt-report llvm-otool
llvm-pdbutil llvm-PerfectShuffle llvm-profdata llvm-profgen llvm-ranlib llvm-rc
llvm-readelf llvm-readobj llvm-reduce llvm-remark-size-diff llvm-remarkutil
llvm-rtdyld llvm-sim llvm-size llvm-split llvm-stress llvm-strings llvm-strip
llvm-symbolizer llvm-tapi-diff llvm-tblgen llvm-tli-checker llvm-undname
llvm-windres llvm-xray"

update_alternatives "${version}" "${priority}" "${master}" "${slaves}" "${path}"

master="clang" slaves="asan_symbolize bugpoint clang++ clang-cpp clangd count
dsymutil FileCheck ld64.lld ld.lld llc lld lldb lldb-argdumper lldb-instr
lldb-server lldb-vscode lld-link lli lli-child-target not obj2yaml opt sanstats
split-file UnicodeNameMappingGenerator verify-uselis torder wasm-ld yaml2obj
yaml-bench"

update_alternatives "${version}" "${priority}" "${master}" "${slaves}" "${path}"

# to uninstall a Clang version
# LLVM_VERSION=12
# sudo apt purge -y clang-${LLVM_VERSION} lldb-${LLVM_VERSION} lld-${LLVM_VERSION} clangd-${LLVM_VERSION} && sudo apt autoremove -y

# to generate the list of slaves on a clean vm
# 0. sudo apt update && sudo apt full-upgrade -y && sudo apt autoremove -y && sudo apt autoclean
# 1. ls /usr/bin > usr_bin_orig
# 2. install the new version of clang
# 3. ls /usr/bin > usr_bin_new
# 4. diff usr_bin_new usr_bin_orig | awk '/^< (llvm-).*-16$/ {gsub("-16",""); printf "%s ", $2} END {print ""}' > slaves_llvm
# 5  diff usr_bin_new usr_bin_orig | awk '/^< / && !/llvm-/ && /-16$/ {gsub("^< ",""); gsub("-16$",""); printf "%s ", $0} END {print ""}' > slaves_clang
