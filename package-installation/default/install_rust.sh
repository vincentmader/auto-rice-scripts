#!/bin/sh


# uninstall rust (if installed)
# if command -v "rustup" &> /dev/null; then
#     rustup self uninstall
#     # brew uninstall rust  # TODO needed?
# fi

printc "Installing rust..."

# download & install base rust
# printf "$COLOR_YELLOW";
# echo "NOTE: choose nightly build" && echo
# printf "$COLOR_DEFAULT"
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- --default-toolchain nightly -y

# use nightly rust build as default
# rustup toolchain install nightly
# rustup install nightly   # TODO needed?
# rustup default nightly

# install wasm-bindgen
source $HOME/.cargo/env
cargo install -f wasm-bindgen-cli
rustup target add wasm32-unknown-unknown

# install diesel
# TODO cargo install diesel-cli
# TODO run: brew services start postgre

# install language server stuff
rustup component add rust-analysis rust-src  # rls


