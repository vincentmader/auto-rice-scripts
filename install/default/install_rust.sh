#!/bin/sh


# uninstall rust (if installed)
rustup self uninstall
# brew uninstall rust  # TODO needed?

# download & install base rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

# use nightly rust build as default
rustup toolchain install nightly
rustup install nightly   # TODO needed?
rustup default nightly

# install wasm-bindgen
cargo install -f wasm-bindgen-cli
rustup target add wasm32-unknown-unknown

# install language server stuff
rustup component add rls rust-analysis rust-src

