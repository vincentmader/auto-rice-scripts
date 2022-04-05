#!/bin/sh


if [ -d $CONF ]; then
    echo_header_l2 "Pulling personal config-dotfile repository..."
    cd $CONF && git pull
else
    echo_header_l2 "Cloning personal config-dotfiles to ~/.config..."
    URL_TO_DOTFILES="https://github.com/vincentmader/config-dotfiles"
    git clone --recurse-submodules $URL_TO_DOTFILES $CONF
fi

