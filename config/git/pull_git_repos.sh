#!/bin/sh


if [ $OS = "arch" ]; then

    # clone wallpapers
    # TODO sudo rm -r $CONF/symlinks/docs/wallpapers 2> /dev/null
    URL_TO_WALLPAPERS="https://github.com/vincentmader/wallpapers"
    git clone $URL_TO_WALLPAPERS $CONF/symlinks/docs/wallpapers
    
    # TODO get code projects
    URL_TO_MXYZ="https://github.com/vincentmader/mader.xyz"
    git clone $URL_TO_MXYZ $CONF/symlinks/code/mader.xyz
    
    # get org files
    URL_TO_ORG="https://github.com/vincentmader/org"
    git clone $URL_TO_ORG $HOME/org

elif [ $OS = "macOS" ]; then
    echo "repo sync is done automatically on macOS (via iCloud)"
fi

