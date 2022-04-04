#!/bin/sh


printc "Installing system packages...\n$SEPARATOR_1"

TO_INSTALL="$RICE/package-installation/default/pkgs_default/to-install.txt"
ALREADY_INSTALLED="$RICE/package-installation/default/pkgs_default/installed.txt"

function INSTALLER {
    if [ "$PACKAGE_MANAGER" = "brew install" ]; then  
        brew info "$1" | grep --quiet "Not installed" && $PACKAGE_MANAGER "$1"
    else 
        $PACKAGE_MANAGER "$1"
    fi
}

if [ "$OS" = "macOS" ]; then
    install_from_pkg_file INSTALLER "$TO_INSTALL" "$ALREADY_INSTALLED"
elif [ "$OS" = "arch" ]; then
    $PACKAGE_MANAGER $(cat $TO_INSTALL)
fi

