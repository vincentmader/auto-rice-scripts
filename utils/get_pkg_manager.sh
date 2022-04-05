#!/bin/sh

if [ "$OS" = "macOS" ] ; then       # arch  -> pacman
    export PACKAGE_MANAGER="brew install"
elif [ "$OS" = "arch" ] ; then      # macOS -> brew
    export PACKAGE_MANAGER="yay -S --needed" 
else                                # exit on undefined
    echo "Please specify the OS ('arch' or 'macOS')"
    exit 1
fi

