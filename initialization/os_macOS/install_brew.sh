#!/bin/sh


echo -e "$COLOR_BLUE\nInstalling brew...$COLOR_DEFAULT"

# exit if brew is already installed
if command -v "brew" &> /dev/null; then
    echo "Already installed."
else
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> $HOME/.zprofile
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi

