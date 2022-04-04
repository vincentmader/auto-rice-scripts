#!/bin/sh


echo -e "$COLOR_BLUE\nInstalling tmux plugins using tpm...$COLOR_DEFAULT"

# remove installed tmux plugins (if existent)
sudo rm -r $CONF/tmux/plugins 2> /dev/null
mkdir $CONF/tmux/plugins

# install tmux package manager
git clone https://github.com/tmux-plugins/tpm.git $CONF/tmux/plugins/tpm

# install tmux plugins using tpm
# TODO execute prefix-I from shell  (how?)

# setup resurrect save directory
mkdir -p $CONF/tmux/resurrect_saves
mkdir -p ~/.tmux
rm ~/.tmux/resurrect 2> /dev/null
ln -s $CONF/tmux/resurrect_saves ~/.tmux/resurrect >> /dev/null

tmux source ~/.config/tmux/tmux.conf

