#!/bin/sh


printc "Setting up home directory at \"$HOME\"..."


mkdir -p $HOME/code

if [ "$OS" = "arch" ]; then
    mkdir -p $HOME/docs
    mkdir -p $HOME/downloads
    mkdir -p $HOME/media/pictures
    mkdir -p $HOME/media/videos

elif [ "$OS" = "macOS" ]; then
    continue
fi

echo "Setup of home directory complete."

