#!/bin/sh


echo "Setting up home directory at $HOME"

mkdir $HOME/downloads

mkdir -p $HOME/docs
mkdir -p $HOME/docs/code
ln -s $HOME/docs/code $HOME/code

mkdir -p $HOME/media/pictures
mkdir -p $HOME/media/videos

