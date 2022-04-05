#!/bin/sh


echo_header_l2 "Setting up home directory at \"$HOME\"..."

mkdir -pv $HOME/code

if [ "$OS" = "arch" ]; then
    mkdir -pv $HOME/docs
    mkdir -pv $HOME/downloads
    mkdir -pv $HOME/media/pictures
    mkdir -pv $HOME/media/videos

elif [ "$OS" = "macOS" ]; then
    continue
fi

echo "Setup of home directory complete."

