#!/bin/sh

echo_header_l2 "Installing neovide..."
PATH_TO_NEOVIDE="$SRC/neovide"

# get source code
if [ ! -d "$PATH_TO_NEOVIDE" ]; then
    git clone https://github.com/neovide/neovide "$PATH_TO_NEOVIDE"
    cd "$PATH_TO_NEOVIDE"
else
    cd "$PATH_TO_NEOVIDE"
    git pull
fi

# generate binaries
cargo build --release

# make accessible
if [ "$OS" == "macOS" ]; then
    echo $COLOR_YELLOW TODO!$COLOR_DEFAULT
    # cargo bundle --release
    # PATH_TO_APP="$PATH_TO_NEOVIDE/target/release/bundle/osx/Neovide.app"
    # cp -r "$PATH_TO_APP" "$HOME/Applications/"
elif [ "$OS" == "arch" ]; then
    echo $COLOR_YELLOW TODO!$COLOR_DEFAULT
fi

cd "$SRC"
