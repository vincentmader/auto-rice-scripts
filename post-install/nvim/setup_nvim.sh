#!/bin/sh


echo "Configuring neovim..."

cd $CONF/nvim/plugged/coc.vim
yarn install

# cd $CONF/coc/extensions
# yarn install

