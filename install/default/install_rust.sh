#!/bin/sh


# uninstall rust (if installed)
if command -v "rustup" &> /dev/null; then
    rustup self uninstall
    # brew uninstall rust  # TODO needed?
fi

# download & install base rust
echo "Installing rust..."
echo "NOTE: choose nightly build"  # TODO
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

# use nightly rust build as default
rustup toolchain install nightly
rustup install nightly   # TODO needed?
rustup default nightly

# install wasm-bindgen
source $HOME/.cargo/env
cargo install -f wasm-bindgen-cli
rustup target add wasm32-unknown-unknown

# install language server stuff
rustup component add rust-analysis rust-src  # rls  TODO not yet possible :(


