#!/bin/sh


if [ -d $CONF ]; then
    echo -e "$COLOR_BLUE\nPulling personal config-dotfile repository...$COLOR_DEFAULT"
    cd $CONF
    git pull
else
    echo -e "$COLOR_BLUE\nCloning personal config-dotfiles to ~/.config...$COLOR_DEFAULT"
    URL_TO_DOTFILES="https://github.com/vincentmader/config-dotfiles"
    git clone --recurse-submodules $URL_TO_DOTFILES $CONF
fi

