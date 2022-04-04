#!/bin/sh


echo "$COLOR_BLUE\nCreating symlinks...$COLOR_DEFAULT"


# define function for setting up link from origin to target in a clean way
# =============================================================================

setup_symlink() {
    ORIGIN="$1"
    TARGET="$2"
    # check if symlink at link-target path already exists -> delete if true 
    if [ -L "$TARGET" ]; then
        rm "$TARGET"
    # check if non-symlink file/dir exists at link-target path -> skip if true
    else
        if [[ -d "$TARGET" || -f "$TARGET" ]]; then
            printf "$COLOR_RED"
            printf "ERROR: "
            printf "$COLOR_DEFAULT"
            printf "Path \"$TARGET\" already exists! -> Skipping link\n"
            return
        fi
    fi
    # link from origin to link-target path
    ln -sv "$ORIGIN" "$TARGET"
}

# setup symlink directory in ~/.config 
# =============================================================================

SYMLINKS="$CONF/symlinks"
mkdir -p $SYMLINKS
# delete old, if existing
rm $SYMLINKS/* 2> /dev/null

# CONFIG FILES
# =============================================================================

setup_symlink       "$CONF/zsh/zprofile"            "$HOME/.zprofile"
setup_symlink       "$CONF/zsh/profile"             "$HOME/.profile"
setup_symlink       "$CONF/bash/bashrc"             "$HOME/.bashrc"

setup_symlink       "$CONF"                         "$SYMLINKS/cf"
setup_symlink       "$HOME"                         "$SYMLINKS/home"

if [ -d $HOME/.emacs.d ]; then
    setup_symlink   "$HOME/.emacs.d"                "$CONF/emacs"
fi
if [ -d $HOME/.doom.d ]; then
    setup_symlink   "$HOME/.doom.d"                 "$CONF/doom"
fi

# HOME/DOCS
# =============================================================================

# code
CODE="$HOME/code"
PROJECTS="$CODE/projects"
setup_symlink       "$CODE"                         "$SYMLINKS/code"
setup_symlink       "$PROJECTS/mader.xyz"           "$SYMLINKS/mxyz"
setup_symlink       "$PROJECTS/auto-rice-scripts"   "$SYMLINKS/rice"

# macOS-specific links
if [ "$OS" = "macOS" ]; then

    LIBRARY="$HOME/Library"
    MOBILE_DOCS="$LIBRARY/Mobile Documents"
    ICLOUD="$MOBILE_DOCS/com~apple~CloudDocs/"

    # link library
    setup_symlink   "$HOME/Library"                 "$SYMLINKS/lib"

    # link icloud
    setup_symlink   "$ICLOUD"                       "$SYMLINKS/icloud"
    setup_symlink   "$ICLOUD"                       "$HOME/icloud"

    # link beorg
        setup_symlink   "$HOME/org"                 "$SYMLINKS/org"
        # BEORG="$MOBILE_DOCS/iCloud~com~appsonthemove~beorg/Documents"
        # setup_symlink   "$BEORG/org"                "$SYMLINKS/org"

    # link docs & downloads
    setup_symlink   "$HOME/Documents"               "$HOME/docs"
    setup_symlink   "$HOME/Documents"               "$SYMLINKS/docs"
    setup_symlink   "$HOME/Downloads"               "$SYMLINKS/dl"

    # link dpsg
    ONEDRIVE="$LIBRARY/CloudStorage/OneDrive-DPSGUlm-Söflingen"
    setup_symlink   "$SYMLINKS/docs/dpsg"           "$SYMLINKS/dpsg"
    setup_symlink   "$PROJECTS/dpsg"                "$SYMLINKS/dpsg/code"
    setup_symlink   "$ONEDRIVE"                     "$SYMLINKS/dpsg/OneDrive"

# arch-specific links
elif [ "$OS" = "arch" ]; then

    setup_symlink   "$HOME/org"                     "$SYMLINKS/org"
    setup_symlink   "$HOME/docs"                    "$SYMLINKS/docs"
    setup_symlink   "$HOME/downloads"               "$SYMLINKS/dl"

fi

# documents
UNI="$SYMLINKS/docs/education/uni"
setup_symlink       "$SYMLINKS/docs"                "$SYMLINKS/dox"
setup_symlink       "$UNI"                          "$SYMLINKS/uni"
setup_symlink       "$SYMLINKS/docs/work"           "$SYMLINKS/work"
