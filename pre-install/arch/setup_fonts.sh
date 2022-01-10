#!/bin/sh


echo "Setting up fonts..."

PATH_TO_HACK_NERD="$RICE/src/fonts/Hack-Regular.ttf"
PATH_TO_FONTS="/usr/share/fonts/"

sudo cp $PATH_TO_HACK_NERD $PATH_TO_FONTS

