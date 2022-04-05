#!/bin/sh


echo_header_l2 "Installing tmux plugins..."

# remove installed tmux plugins (if existent)
sudo rm -r $CONF/tmux/plugins 2> /dev/null
mkdir $CONF/tmux/plugins


# install tmux package manager
# -----------------------------------------------------------------------------

    printc "++ tmux package manager\n" "$COLOR_GREEN"
    # install tmux package manager
    git clone https://github.com/tmux-plugins/tpm.git $CONF/tmux/plugins/tpm

# install tmux plugins using tpm
# -----------------------------------------------------------------------------
    # TODO execute prefix-I from shell  (how?)

# setup tmux resurrect
# -----------------------------------------------------------------------------

    printc "++ tmux resurrect\n" "$COLOR_GREEN"
    # setup resurrect save directory
    mkdir -p $CONF/tmux/resurrect_saves
    mkdir -p ~/.tmux
    rm ~/.tmux/resurrect 2> /dev/null
    ln -s $CONF/tmux/resurrect_saves ~/.tmux/resurrect >> /dev/null

# source tmux config
# -----------------------------------------------------------------------------

    printc "** sourcing tmux config\n"
    tmux source ~/.config/tmux/tmux.conf
    printf "$COLOR_YELLOW"
    echo "NOTE: Run Ctrl-Shift-I, then Ctrl-A Ctrl-R"
    printf "$COLOR_DEFAULT"

