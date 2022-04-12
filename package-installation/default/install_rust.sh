#!/bin/sh


# Uninstall Rust
# -----------------------------------------------------------------------------

UNINSTALL_RUST="false"
if [ "$UNINSTALL_RUST" = "true" ]; then
    if command -v "rustup" &> /dev/null; then
        rustup self uninstall
    fi
fi

# Install Rust (Stable)
# -----------------------------------------------------------------------------

echo_header_l2 "Installing rust..."
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
    # -s -- --default-toolchain nightly -y

    # https://rust-lang.github.io/rustup/overrides.html#the-toolchain-file

# Install wasm-bindgen
# -----------------------------------------------------------------------------

echo_header_l2 "Installing wasm-bindgen..."
source $HOME/.cargo/env
cargo install -f wasm-bindgen-cli
rustup target add wasm32-unknown-unknown

# Install development tools
# -----------------------------------------------------------------------------

echo_header_l2 "Installing rust development tools..."
rustup component add rust-analysis rust-src rls

# Install Diesel DB CLI
# -----------------------------------------------------------------------------

cargo install diesel_cli
# TODO if error:
#      -> install libpq          (for postgresql)
#      -> install libmysqlclient (for mysql)

# TODO run: 
# sudo brew services start postgre

# -----------------------------------------------------------------------------

# rustup toolchain install nightly
# rustup install nightly

# rustup default nightly
# rustup default nightly-2020-07-27
