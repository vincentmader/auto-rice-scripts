#!/bin/sh


echo "Pulling personal git repos..."

if [ $OS = "arch" ]; then

    # clone wallpapers
    PATH_TO_WALLPAPERS="$CONF/symlinks/docs/wallpapers"  # TODO move to ~/media/wallpapers (?)
    if [ -d $PATH_TO_WALLPAPERS ]; then
        cd $PATH_TO_WALLPAPERS
        git pull
    else
        URL_TO_WALLPAPERS="https://github.com/vincentmader/wallpapers"
        git clone $URL_TO_WALLPAPERS $PATH_TO_WALLPAPERS
    fi
    # setup wallpaper
    WALLPAPER="macOS/10-6_Snow-Leopard_Server-6k.jpg"
    feh --bg-scale "$PATH_TO_WALLPAPERS/$WALLPAPER"
    
    # get code projects  (TODO get others)
    PATH_TO_CODE="$CONF/symlinks/code"

    PATH_TO_MXYZ="$PATH_TO_CODE/mader.xyz"
    if [ -d $PATH_TO_MXYZ ]; then
        cd $PATH_TO_MXYZ
        git pull
    else
        URL_TO_MXYZ="https://github.com/vincentmader/mader.xyz"
        git clone $URL_TO_MXYZ $PATH_TO_MXYZ
    fi
    
    # get org files
    PATH_TO_ORG="$CONF/SYMLINKS/docs/org"
    if [ -d $PATH_TO_ORG ]; then
        cd $PATH_TO_ORG
        git pull
    else
        URL_TO_ORG="https://github.com/vincentmader/org"
        git clone $URL_TO_ORG $PATH_TO_ORG
    fi

elif [ $OS = "macOS" ]; then
    echo "  -> repo sync is done automatically on macOS (via iCloud)"
fi

