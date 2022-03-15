#!/bin/sh


echo "$COLOR_BLUE\nCreating symlinks...$COLOR_DEFAULT"

# setup symlink directory in ~/.config (delete old, if existing)
# -----------------------------------------------------------------------------

SYMLINKS="$CONF/symlinks"
mkdir -p $SYMLINKS
rm $SYMLINKS/* 2> /dev/null
rm $CONF/emacs 2> /dev/null
rm $CONF/doom 2> /dev/null
rm $HOME/docs 2> /dev/null
rm $HOME/docs/dpsg 2> /dev/null
rm $HOME/code 2> /dev/null
rm $HOME/org 2> /dev/null


# create symlinks
# -----------------------------------------------------------------------------

# symlink to home & config
ln -s $HOME $SYMLINKS/home
ln -s $CONF $SYMLINKS/cf

# symlink to .emacs.d & .doom.d from ~/.config
if [ -d $HOME/.emacs.d ]; then
    ln -s $HOME/.emacs.d $CONF/emacs
fi
if [ -d $HOME/.doom.d ]; then
    ln -s $HOME/.doom.d $CONF/doom
fi

# symlink to bashrc
rm $HOME/.bashrc 2> /dev/null
ln -s $CONF/bash/bashrc $HOME/.bashrc 

# symlink to documents & downloads  (also to iCloud, if on macOS)
if [ "$OS" = "macOS" ]; then

    # link library to symlinks/lib
    LIBRARY="$HOME/Library"
    ln -s "$HOME/Library"   $SYMLINKS/lib

    # needed for the iCloud & beorg
    MOBILE_DOCS="$LIBRARY/Mobile Documents"
    ICLOUD="$MOBILE_DOCS/com~apple~CloudDocs/"

    # link iCloud files to ~/cloud
    ln -s "$ICLOUD" $SYMLINKS/icloud           

    # link beorg 
    BEORG="$MOBILE_DOCS/iCloud~com~appsonthemove~beorg/Documents"
    ln -s "$BEORG/org"      $SYMLINKS/org         # cloud/org   -> sl/org

    # link ~/Documents and ~/Downloads
    ln -s "$HOME/Documents" $HOME/docs            # home/Docs   -> home/docs
    ln -s "$SYMLINKS/icloud" $HOME/icloud         # sl/icloud   -> home/icloud
    ln -s "$HOME/Documents" $SYMLINKS/docs        # home/Docs   -> sl/docs
    ln -s "$HOME/Downloads" $SYMLINKS/dl          # home/Dl     -> sl/dl

elif [ "$OS" = "arch" ]; then

    ln -s "$HOME/docs/org" $SYMLINKS/org          # docs/org    -> sl/org  
    ln -s $HOME/docs $SYMLINKS/docs               # home/docs   -> sl/docs
    ln -s $HOME/downloads $SYMLINKS/dl            # home/dl     -> sl/dl

fi

# symlinks to documents
ln -s $SYMLINKS/docs $SYMLINKS/dox                # sl/docs     -> sl/dox
ln -s $SYMLINKS/docs/education/uni $SYMLINKS/uni  # docs/un     -> sl/uni
ln -s $SYMLINKS/docs/work $SYMLINKS/work          # docs/work   -> sl/work
ln -s $SYMLINKS/docs/dpsg $SYMLINKS/dpsg          # docs/work   -> sl/work

# symlinks to code
# ln -s $SYMLINKS/docs/code $SYMLINKS/code          # docs/code   -> sl/code
# ln -s $SYMLINKS/docs/code $HOME/code              # docs/code   -> home/code
ln -s $HOME/code $SYMLINKS/code          # docs/code   -> sl/code
ln -s $SYMLINKS/code/mader.xyz $SYMLINKS/mxyz     # code/mxyz   -> sl/mxyz
ln -s $SYMLINKS/code/auto-rice-scripts $SYMLINKS/rice     # code/mxyz   -> sl/mxyz

# symlink to org files from home
ln -s $SYMLINKS/org $HOME/org                     # sl/org      -> home/org

echo "  -> created symlinks"

