#!/bin/sh


echo_header_l2 "Creating symlinks..."


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

# CONFIG FILES
# =============================================================================

setup_symlink       "$CONF/zsh/zshenv"              "$HOME/.zshenv"
setup_symlink       "$CONF/zsh/zprofile"            "$HOME/.zprofile"
setup_symlink       "$CONF/zsh/zshrc"               "$HOME/.zshrc"
# setup_symlink       "$CONF/bash/profile"            "$HOME/.profile"
# setup_symlink       "$CONF/bash/bash_profile"       "$HOME/.bash_profile"
# setup_symlink       "$CONF/bash/bashrc"             "$HOME/.bashrc"

# link ~/.emacs.d to .config/emacs
if [ -d $HOME/.emacs.d ]; then
    setup_symlink   "$HOME/.emacs.d"                "$CONF/emacs"
fi
# link ~/.doom.d to .config/emacs
if [ -d $HOME/.doom.d ]; then
    setup_symlink   "$HOME/.doom.d"                 "$CONF/doom"
fi

setup_symlink       "$CONF"                         "$SYMLINKS/cf"

# macOS-specific links
# =============================================================================
if [ "$OS" = "macOS" ]; then
    # define location of User Sytem Library (needed for e.g. Mobile Documents)
    LIBRARY="$HOME/Library"
    # define location of iCloud Mobile Documents
    MOBILE_DOCS="$LIBRARY/Mobile Documents"
    # define location of CloudDocs (cloud-synced Documents, Downloads etc.)
    CDOCS="$MOBILE_DOCS/com~apple~CloudDocs/"
    # define location of Documents folder (here: equal to "$Mobile\ Docs/Documents")
    DOCS="$HOME/Documents"

    # link CloudDocs (TODO rename: icloud->cdocs ? -> would be more specific)
    setup_symlink   "$CDOCS"                       "$SYMLINKS/icloud"
    setup_symlink   "$CDOCS"                       "$HOME/iCloud"

    # link DPSG stuff
    ONEDRIVE="$LIBRARY/CloudStorage/OneDrive-DPSGUlm-Söflingen"
    setup_symlink   "$ONEDRIVE"                     "$SYMLINKS/dpsg/OneDrive"
    # setup_symlink   "$SYMLINKS/docs/Projects/DPSG  Leiter & StaVo"  "$SYMLINKS/dpsg"
    # setup_symlink   "$PROJECTS/dpsg"                "$SYMLINKS/dpsg/code"

    # link Pictures
    setup_symlink   "$CDOCS/Pictures"               "$HOME/org/LTM/Pictures"
    # link Movies
    setup_symlink   "$CDOCS/Movies"                 "$HOME/org/LTM/Movies"

    # link library
        # setup_symlink   "$HOME/Library"                 "$SYMLINKS/lib"

    # link beorg
        # BEORG="$MOBILE_DOCS/iCloud~com~appsonthemove~beorg/Documents"
        # setup_symlink   "$BEORG/org"                "$SYMLINKS/org"

# arch-specific links
# =============================================================================
elif [ "$OS" = "arch" ]; then
    # define location of Documents folder (here: equal to "$HOME/docs")
    DOCS="$HOME/docs"

    # link XORG initialization config file (xinitrc)
    sudo rm /etc/X11/xinit/xinitrc
    sudo ln -sv     "$CONF/x/xinitrc"               "/etc/X11/xinit/xinitrc"

else
    pass  # (will print error/warning message at EOF)
fi

# HOME/CODE/DOCS
# =============================================================================

# link Home directory
setup_symlink       "$HOME"                         "$SYMLINKS/home"
# link Documents directory
setup_symlink       "$DOCS"                         "$SYMLINKS/docs"
# link Downloads directory
setup_symlink       "$HOME/Downloads"               "$SYMLINKS/dl"
# link Org files
setup_symlink       "$HOME/org"                     "$SYMLINKS/org"

# define location of Projects directory
PROJECTS="$SYMLINKS/org/PRJs"
# link projects
setup_symlink       "$PROJECTS"                     "$SYMLINKS/prjs"
setup_symlink       "$PROJECTS/dpsg"                "$SYMLINKS/dpsg"
setup_symlink  "$PROJECTS/auto-rice-scripts.nosync" "$SYMLINKS/rice"
setup_symlink       "$PROJECTS/mader.xyz"           "$SYMLINKS/mxyz"
# define location of University notes directory
UNI="$PROJECTS/UHD B.Sc. & M.Sc."
# link University notes directory
setup_symlink       "$PROJECTS/University"          "$SYMLINKS/uni"

# link Work directory
setup_symlink       "$PROJECTS/_work"           "$SYMLINKS/work"

# TODO os-specific setup, code ~/code OR $CDOCS/Documents/code.nosync
# code
# CODE="$HOME/code"
# PROJECTS="$CODE/projects"
# setup_symlink       "$CODE"                         "$SYMLINKS/code"
# setup_symlink       "$CODE"                         "$SYMLINKS/code"
# setup_symlink       "$PROJECTS/mader.xyz"           "$SYMLINKS/mxyz"
# setup_symlink       "$PROJECTS/auto-rice-scripts"   "$SYMLINKS/rice"

if [ "$OS" = "" ]; then
    echo "\n\033[0;31mPlease specify \`\$OS\` !\033[0m (e.g. with \`OS=\"macOS\"\`)"
fi
