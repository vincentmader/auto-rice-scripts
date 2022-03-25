#!/bin/sh


if [ -d $CONF ]; then
    echo "$COLOR_BLUE\nPulling config files from GitHub repo...$COLOR_DEFAULT"
    cd $CONF
    git pull
else
    echo "Cloning config files to $HOME/.config"
    URL_TO_DOTFILES="https://github.com/vincentmader/config-dotfiles"
    git clone --recurse-submodules $URL_TO_DOTFILES $CONF
fi

