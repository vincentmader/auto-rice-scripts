#!/bin/sh


printc "Installing tmux plugins using tpm..."

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

printf "$COLOR_YELLOW"
echo "\nNOTE: Run Ctrl-Shift-I, then Ctrl-A Ctrl-R"
printf "$COLOR_DEFAULT"

