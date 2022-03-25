#!/bin/sh


echo "$COLOR_BLUE\nPulling personal git repos...$COLOR_DEFAULT"


# clone wallpapers
echo "\n$COLOR_BLUE**$COLOR_DEFAULT wallpapers"
PATH_TO_WALLPAPERS="$CONF/symlinks/docs/wallpapers"  # TODO move to ~/media/wallpapers (?)
if [ -d $PATH_TO_WALLPAPERS ]; then
    cd $PATH_TO_WALLPAPERS
    git pull
else
    URL_TO_WALLPAPERS="https://github.com/vincentmader/wallpapers"
    git clone $URL_TO_WALLPAPERS $PATH_TO_WALLPAPERS
fi

if [ "$OS" = "arch" ]; then
    # setup wallpaper
    WALLPAPER="macOS/10-6_Snow-Leopard_Server-6k.jpg"
    feh --bg-scale "$PATH_TO_WALLPAPERS/$WALLPAPER"
fi

# get code projects  (TODO get others)
PATH_TO_CODE="$CONF/symlinks/code"

echo "\n$COLOR_BLUE**$COLOR_DEFAULT mader.xyz"  # TODO adjust path
# PATH_TO_MXYZ="$PATH_TO_CODE/projects/mader.xyz/main"  
# if [ -d $PATH_TO_MXYZ ]; then
#     cd $PATH_TO_MXYZ
#     git pull
# else
#     echo ay
#     # URL_TO_MXYZ="https://github.com/vincentmader/mader.xyz"
#     # git clone $URL_TO_MXYZ $PATH_TO_MXYZ
# fi

# get org files
echo "\n$COLOR_BLUE**$COLOR_DEFAULT org"
PATH_TO_ORG="$CONF/symlinks/org"
if [ -d $PATH_TO_ORG ]; then
    cd $PATH_TO_ORG
    git pull
else
    echo ay
    # URL_TO_ORG="https://github.com/vincentmader/org"
    # git clone $URL_TO_ORG $PATH_TO_ORG
fi

