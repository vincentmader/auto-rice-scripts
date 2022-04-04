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
    if [ -d "$PATH_TO_WALLPAPERS" ]; then
        cd $PATH_TO_WALLPAPERS && git pull
    else
        git clone https://github.com/vincentmader/wallpapers $PATH_TO_WALLPAPERS
    fi
    feh --bg-scale "$PATH_TO_WALLPAPERS/macOS/10-6_Snow-Leopard_Server-6k.jpg"

    # org
    PATH_TO_ORG="$HOME/org"   # TODO
    if [ -d "$PATH_TO_ORG" ]; then
        cd "$PATH_TO_ORG" && git pull
    else 
        URL_TO_ORG="https://github.org/vincentmader/org"
        git clone "$URL_TO_ORG" "$PATH_TO_ORG"
    fi

elif [ "$OS" = "macOS" ]; then
    continue
fi

echo "Setup of home directory complete."

