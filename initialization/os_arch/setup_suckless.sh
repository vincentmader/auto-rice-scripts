#!/bin/sh


function clone_suckless_repo {
    PATH_TO_SRC="$CONF/$1"
    printc "Setting up $1 at \"$PATH_TO_SRC\"..."

    if [ -d "$PATH_TO_SRC" ]; then
        cd "$PATH_TO_SRC"
        git pull
    else
        URL_TO_REPO="https://github.com/vincentmader/$1"
        git clone "$URL_TO_REPO" "$PATH_TO_SRC"
        cd "$PATH_TO_SRC"
    fi

    sudo make clean install
    echo "$1 setup complete"
}

clone_suckless_repo "dwm"
clone_suckless_repo "st"
clone_suckless_repo "dmenu"
clone_suckless_repo "tabbed"

