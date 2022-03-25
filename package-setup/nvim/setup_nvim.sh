#!/bin/sh


echo "$COLOR_BLUE\nConfiguring neovim...$COLOR_DEFAULT"

cd $CONF/nvim/plugged/coc.vim
yarn install

# cd $CONF/coc/extensions
# yarn install

