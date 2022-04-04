#!/bin/sh


echo -e "$COLOR_BLUE\nInstalling neovim plugins using vim-plug...$COLOR_DEFAULT"


if [ $OS = "arch" ]; then
    echo                               # TODO remove this line

    # cd $CONF/nvim/plugged/coc.vim    # TODO needed? (maybe)
    # yarn install

    # cd $CONF/coc/extensions          # TODO needed? (don't think so)
    # yarn install
fi

# install nvim plugins using junegunn/vim-plug
nvim -c PlugInstall &  
# reload 2nd time for completion-plugin downloads using neoclide/coc
nvim -c PlugInstall & 

