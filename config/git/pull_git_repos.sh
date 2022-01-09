#!/bin/sh


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
    
    # TODO get code projects
    URL_TO_MXYZ="https://github.com/vincentmader/mader.xyz"
    git clone $URL_TO_MXYZ $CONF/symlinks/code/mader.xyz
    
    # get org files
    URL_TO_ORG="https://github.com/vincentmader/org"
    git clone $URL_TO_ORG $HOME/org

elif [ $OS = "macOS" ]; then
    echo "repo sync is done automatically on macOS (via iCloud)"
fi

