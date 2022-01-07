#!/bin/sh


if [ ! -d $CONF ]; then

    URL_TO_DOTFILES="https://github.com/vincentmader/config-dotfiles"
    git clone --recurse-submodules $URL_TO_DOTFILES $CONF

    if [ "$OS" = "arch" ]; then
        git clone https://github.com/vincentmader/dmenu $CONF/dmenu
        git clone https://github.com/vincentmader/dwm $CONF/dwm
        git clone https://github.com/vincentmader/st $CONF/st
    fi

fi

