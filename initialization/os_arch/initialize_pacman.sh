#!/bin/sh


echo_header_l2 "Setting up pacman..."

sudo pacman-key --init
sudo pacman -Syu

