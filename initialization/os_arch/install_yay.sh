#!/bin/sh


echo -e "$COLOR_BLUE\nInstalling yay...$COLOR_DEFAULT"

# exit if yay is already installed
if command -v "yay" &> /dev/null
then
    echo "Already installed."
else
    # download yay
    sudo rm -r $SRC/yay 2> /dev/null
    git clone https://aur.archlinux.org/yay.git $SRC/yay
    
    # install
    cd $SRC/yay
    makepkg -si
fi

