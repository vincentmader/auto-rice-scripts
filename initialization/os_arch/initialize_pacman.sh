#!/bin/sh


printc "Setting up pacman..."

sudo pacman-key --init
sudo pacman -Syu

