#!/bin/sh


echo "Installing yay..."

# exit if yay is already installed
if command -v "yay" &> /dev/null
then
    echo "  -> yay is already installed!"
    exit
fi

# download yay
sudo rm -r $SRC/yay 2> /dev/null
git clone https://aur.archlinux.org/yay.git $SRC/yay

# install
cd $SRC/yay
makepkg -si

