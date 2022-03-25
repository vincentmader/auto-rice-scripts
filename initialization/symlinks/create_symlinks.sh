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
rm $HOME/icloud 2> /dev/null


# create symlinks
# -----------------------------------------------------------------------------

# symlink to home & config
ln -sv $HOME $SYMLINKS/home
ln -sv $CONF $SYMLINKS/cf

# symlink to .emacs.d & .doom.d from ~/.config
if [ -d $HOME/.emacs.d ]; then
    ln -sv $HOME/.emacs.d $CONF/emacs
fi
if [ -d $HOME/.doom.d ]; then
    ln -sv $HOME/.doom.d $CONF/doom
fi

# symlink to bashrc
rm $HOME/.bashrc 2> /dev/null
ln -sv $CONF/bash/bashrc $HOME/.bashrc 

# symlink to documents & downloads  (also to iCloud, if on macOS)
if [ "$OS" = "macOS" ]; then

    # link library to symlinks/lib
    LIBRARY="$HOME/Library"
    ln -sv "$HOME/Library"   $SYMLINKS/lib

    # needed for the iCloud & beorg
    MOBILE_DOCS="$LIBRARY/Mobile Documents"
    ICLOUD="$MOBILE_DOCS/com~apple~CloudDocs/"

    # link iCloud files to ~/cloud
    ln -sv "$ICLOUD" $SYMLINKS/icloud           

    # link beorg 
    BEORG="$MOBILE_DOCS/iCloud~com~appsonthemove~beorg/Documents"
    # ln -sv "$BEORG/org"      $SYMLINKS/org         # cloud/org   -> sl/org
    ln -sv $HOME/org $SYMLINKS/org                 # home/org    -> sl/org

    # link ~/Documents and ~/Downloads
    ln -sv "$HOME/Documents" $HOME/docs            # home/Docs   -> home/docs
    ln -sv "$SYMLINKS/icloud" $HOME/icloud         # sl/icloud   -> home/icloud
    ln -sv "$HOME/Documents" $SYMLINKS/docs        # home/Docs   -> sl/docs
    ln -sv "$HOME/Downloads" $SYMLINKS/dl          # home/Dl     -> sl/dl

elif [ "$OS" = "arch" ]; then

    # ln -sv "$HOME/docs/org" $SYMLINKS/org          # docs/org    -> sl/org  
    ln -sv "$HOME/org" $SYMLINKS/org               # home/org    -> sl/org  
    ln -sv $HOME/docs $SYMLINKS/docs               # home/docs   -> sl/docs
    ln -sv $HOME/downloads $SYMLINKS/dl            # home/dl     -> sl/dl

fi

# symlinks to documents
ln -sv $SYMLINKS/docs $SYMLINKS/dox                # sl/docs     -> sl/dox
ln -sv $SYMLINKS/docs/education/uni $SYMLINKS/uni  # docs/un     -> sl/uni
ln -sv $SYMLINKS/docs/work $SYMLINKS/work          # docs/work   -> sl/work
ln -sv $SYMLINKS/docs/dpsg $SYMLINKS/dpsg          # docs/work   -> sl/work

# symlinks to code
# ln -sv $SYMLINKS/docs/code $SYMLINKS/code          # docs/code   -> sl/code
# ln -sv $SYMLINKS/docs/code $HOME/code              # docs/code   -> home/code
ln -sv $HOME/code $SYMLINKS/code          # docs/code   -> sl/code
ln -sv $SYMLINKS/code/projects/mader.xyz $SYMLINKS/mxyz     # code/mxyz   -> sl/mxyz
ln -sv $SYMLINKS/code/projects/auto-rice-scripts $SYMLINKS/rice     # code/mxyz   -> sl/mxyz

# symlink to org files from home
# ln -sv $SYMLINKS/org $HOME/org                     # sl/org      -> home/org

