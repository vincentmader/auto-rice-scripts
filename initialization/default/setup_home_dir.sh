#!/bin/sh


printc "Setting up home directory at \"$HOME\"..."


mkdir -p $HOME/code

if [ "$OS" = "arch" ]; then
    mkdir -p $HOME/docs
    mkdir -p $HOME/downloads
    mkdir -p $HOME/media/pictures
    mkdir -p $HOME/media/videos

    # download & set wallpapers 
    PATH_TO_WALLPAPERS="$HOME/media/pictures/wallpapers"
    git clone https://github.com/vincentmader/wallpapers $PATH_TO_WALLPAPERS
    feh --bg-scale "$PATH_TO_WALLPAPERS/macOS/10-6_Snow-Leopard_Server-6k.jpg"

elif [ "$OS" = "macOS" ]; then
    continue
fi

echo "Setup of home directory complete."

