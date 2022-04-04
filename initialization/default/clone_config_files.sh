#!/bin/sh


if [ -d $CONF ]; then
    printc "Pulling personal config-dotfile repository..."
    cd $CONF && git pull
else
    printc "Cloning personal config-dotfiles to ~/.config..."
    URL_TO_DOTFILES="https://github.com/vincentmader/config-dotfiles"
    git clone --recurse-submodules $URL_TO_DOTFILES $CONF
fi

