#!/bin/sh


echo_header_l2 "Setting up xorg..."

sudo rm /etc/X11/xinit/xinitrc > /dev/null
sudo ln -sv $CONF/x/source_xinit /etc/X11/xinit/xinitrc

# printc "xorg setup complete.\n" "$COLOR_GREEN"

