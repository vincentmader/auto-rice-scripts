#!/bin/sh


# dwm
    echo "Setting up dwm..."
    sudo rm -r $CONF/dwm 2> /dev/null
    URL_TO_DWM="https://github.com/vincentmader/dwm"
    git clone $URL_TO_DWM $CONF/dwm
    cd $CONF/dwm
    rm config.h 2> /dev/null
    sudo make clean install

# st
    echo "Setting up st..."
    sudo rm -r $CONF/st 2> /dev/null
    URL_TO_ST="https://github.com/vincentmader/st"
    git clone $URL_TO_ST $CONF/st
    cd $CONF/st
    rm config.h 2> /dev/null
    sudo make clean install

# dmenu
    # echo "Setting up dmenu..."
    # sudo rm -r $CONF/dmenu 2> /dev/null
    # URL_TO_DMENU="https://github.com/vincentmader/dmenu"
    # git clone $URL_TO_DMENU $CONF/dmenu
    # cd $CONF/dmenu
    # rm config.h 2> /dev/null
    # sudo make clean install

# TODO tabbed 

