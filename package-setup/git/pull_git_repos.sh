#!/bin/sh


echo_header_l2 "Pulling personal git repos..."


# clone wallpapers (& setup on Arch)
# =============================================================================

    if [ "$OS" = "arch" ]; then
        PATH_TO_WALLPAPERS="$HOME/media/pictures/wallpapers"
    elif [ "$OS" = "macOS" ]; then
        # TODO move to ~/Pictures/wallpapers (?)
        PATH_TO_WALLPAPERS="$CONF/symlinks/docs/wallpapers"  
    fi
    if [ -d "$PATH_TO_WALLPAPERS" ]; then
        printc "** wallpapers\n"
        cd "$PATH_TO_WALLPAPERS" && git pull
    else
        printc "++ wallpapers\n" "$COLOR_GREEN"
        URL_TO_WALLPAPERS="https://github.com/vincentmader/wallpapers"
        git clone $URL_TO_WALLPAPERS $PATH_TO_WALLPAPERS
    fi
    # setup wallpaper
    if [ "$OS" = "arch" ]; then
        WALLPAPER="macOS/10-6_Snow-Leopard_Server-6k.jpg"
        feh --bg-scale "$PATH_TO_WALLPAPERS/$WALLPAPER"
    fi

# get code projects  
# =============================================================================

    PATH_TO_CODE="$CONF/symlinks/code"
    
    PATH_TO_MXYZ="$PATH_TO_CODE/projects/mader.xyz/main"  # TODO adjust path
    if [ -d $PATH_TO_MXYZ ]; then
        printc "** mader.xyz\n"
        cd $PATH_TO_MXYZ && git pull
    else
        printc  "++ mader.xyz\n" "$COLOR_GREEN"
        URL_TO_MXYZ="https://github.com/vincentmader/mader.xyz"
        git clone $URL_TO_MXYZ $PATH_TO_MXYZ
    fi

    # TODO get other projects

# get org files
# =============================================================================

    PATH_TO_ORG="$CONF/symlinks/org"
    if [ -d "$PATH_TO_ORG" ]; then
        printc "** org\n"
        cd "$PATH_TO_ORG" && git pull
    else
        printc "++ org\n" "$COLOR_GREEN"
        URL_TO_ORG="https://github.com/vincentmader/org"
        git clone "$URL_TO_ORG" "$PATH_TO_ORG"
    fi
    
