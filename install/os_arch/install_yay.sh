#!/bin/sh


# download yay
sudo rm -r $SRC/yay 2> /dev/null
git clone https://aur.archlinux.org/yay.git $SRC/yay

# install
cd $SRC/yay
makepkg -si

