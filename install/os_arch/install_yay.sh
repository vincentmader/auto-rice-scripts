#!/bin/sh


if command -v "yay" &> /dev/null
then
    exit
fi

# download yay
sudo rm -r $SRC/yay 2> /dev/null
git clone https://aur.archlinux.org/yay.git $SRC/yay

# install
cd $SRC/yay
makepkg -si

