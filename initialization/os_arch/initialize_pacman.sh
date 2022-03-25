#!/bin/sh


echo "$COLOR_BLUE\nSetting up pacman...$COLOR_DEFAULT"

sudo pacman-key --init
sudo pacman -Syu

