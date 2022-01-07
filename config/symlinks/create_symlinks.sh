#!/bin/sh


# setup symlink directory in ~/.config (delete old, if existing)
# -----------------------------------------------------------------------------

SYMLINKS="$CONF/symlinks"
mkdir -p $SYMLINKS
rm $SYMLINKS/* 
rm $CONF/emacs
rm $CONF/doom
rm $HOME/code


# create symlinks
# -----------------------------------------------------------------------------

# symlink to home, config
ln -s $HOME $SYMLINKS/home
ln -s $CONF $SYMLINKS/cf
ln -s $HOME/.emacs.d $CONF/emacs
ln -s $HOME/.doom.d $CONF/doom

# symlink to documents & downloads  (also to iCloud, if on macOS)
if [ "$OS" = "macOS" ]; then
    ln -s $HOME/Documents $SYMLINKS/docs
    ICLOUD="$HOME/Library/Mobile Documents/com~apple~CloudDocs/"
    ln -s "$ICLOUD/Documents/org" $SYMLINKS/org
    ln -s $HOME/Downloads $SYMLINKS/dl
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
rm $HOME/org
ln -s $SYMLINKS/org $HOME/org

