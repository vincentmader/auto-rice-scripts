#!/bin/sh


echo_header_l2 "Installing neovim plugins using vim-plug..."

# install nvim plugins using junegunn/vim-plug
nvim -c PlugInstall &  
# reload 2nd time for completion-plugin downloads using neoclide/coc
nvim -c PlugInstall & 

