#!/bin/sh


echo "Installing brew..."

# exit if brew is already installed
if command -v "brew" &> /dev/null
then
    echo "  -> brew is already installed!"
    exit
fi

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> $HOME/.zprofile
eval "$(/opt/homebrew/bin/brew shellenv)"

