#!/bin/bash -ex

curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh


rustup toolchain install nightly
rustup default nightly
rustup component add rls
rustup cocomponent add rust-analyzer-preview
rustup component add clippy-preview
rustup component add rustfmt-preview
rustup component add rust-src

cargo install cargo-check
cargo install cargo-nextes
cargo install cargo-watch

brew install rust-analyzer



# ref:
# https://rust-analyzer.github.io/manual.html#installation
# https://docs.doomemacs.org/latest/modules/lang/rust/
# https://github.com/doomemacs/doomemacs/tree/master/modules/lang/rust
