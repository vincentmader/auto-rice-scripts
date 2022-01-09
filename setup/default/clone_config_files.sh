#!/bin/sh


if [ -d $CONF ]; then

    cd $CONF
    git pull

else

    URL_TO_DOTFILES="https://github.com/vincentmader/config-dotfiles"
    git clone --recurse-submodules $URL_TO_DOTFILES $CONF

fi

