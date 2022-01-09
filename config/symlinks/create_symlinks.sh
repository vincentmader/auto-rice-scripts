#!/bin/sh


# setup symlink directory in ~/.config (delete old, if existing)
# -----------------------------------------------------------------------------

SYMLINKS="$CONF/symlinks"
mkdir -p $SYMLINKS
rm $SYMLINKS/* 2> /dev/null
rm $CONF/emacs 2> /dev/null
rm $CONF/doom 2> /dev/null
rm $HOME/docs 2> /dev/null
rm $HOME/code 2> /dev/null
rm $HOME/org 2> /dev/null


# create symlinks
# -----------------------------------------------------------------------------

# symlink to home, config
ln -s $HOME $SYMLINKS/home
ln -s $CONF $SYMLINKS/cf

if [ -d $HOME/.emacs.d ]; then
    ln -s $HOME/.emacs.d $CONF/emacs
fi
if [ -d $HOME/.doom.d ]; then
    ln -s $HOME/.doom.d $CONF/doom
fi

# link bashrc
rm $HOME/.bashrc 2> /dev/null
ln -s $CONF/bash/bashrc $HOME/.bashrc 

# symlink to documents & downloads  (also to iCloud, if on macOS)
if [ "$OS" = "macOS" ]; then
    ln -s $HOME/Documents $SYMLINKS/docs
    ICLOUD="$HOME/Library/Mobile Documents/com~apple~CloudDocs/"
    ln -s "$ICLOUD/Documents/org" $SYMLINKS/org
    ln -s $HOME/Downloads $SYMLINKS/dl
    ln -s $HOME/Documents $HOME/docs
    ln -s $HOME/Documents/code $HOME/code
elif [ "$OS" = "arch" ]; then
    ln -s $HOME/docs $SYMLINKS/docs
    ln -s $HOME/downloads $SYMLINKS/dl
fi
ln -s $SYMLINKS/docs $SYMLINKS/dox
ln -s $SYMLINKS/docs/education/uni $SYMLINKS/uni
ln -s $SYMLINKS/docs/work $SYMLINKS/work

# symlink to code
ln -s $SYMLINKS/docs/code $SYMLINKS/code
ln -s $SYMLINKS/code/mader.xyz $SYMLINKS/mxyz

# symlink to org files
ln -s $SYMLINKS/org $HOME/org

