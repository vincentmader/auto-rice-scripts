#!/bin/sh


# download yay
git clone https://aur.archlinux.org/yay.git $SRC/yay

# install
cd $SRC/yay
makepkg -si

