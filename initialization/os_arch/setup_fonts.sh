#!/bin/sh


printc "Setting up fonts..."
    # to show fonts: `fc-list`
    # actual names: `fc-list | awk -F ":" '{ print $2 }' | uniq`
    # get full name from .ttf -> right-click -> Get Info

PATH_TO_HACK_NERD="$RICE/src/fonts/Hack-Regular.ttf"
PATH_TO_FONTS="$HOME/.local/share/fonts/"
    # global: PATH_TO_FONTS="/usr/share/fonts/"

mkdir -pv "$PATH_TO_FONTS"
rm "$PATH_TO_FONTS/Hack-Regular.ttf"
sudo ln -sv $PATH_TO_HACK_NERD $PATH_TO_FONTS

echo "Setup of fonts complete."

