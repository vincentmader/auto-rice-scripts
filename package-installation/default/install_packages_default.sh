#!/bin/sh


echo "$COLOR_BLUE\nInstalling system packages...$COLOR_DEFAULT"
echo_separator_1

TO_INSTALL="$RICE/package-installation/default/pkgs_default/to-install.txt"
ALREADY_INSTALLED="$RICE/package-installation/default/pkgs_default/installed.txt"

function INSTALLER {
    if [ "$PACKAGE_MANAGER" = "brew install" ]; then  
        brew info "$1" | 
        grep --quiet "Not installed" && 
        $PACKAGE_MANAGER "$1"
    else 
        $PACKAGE_MANAGER "$1"
        # $PACKAGE_MANAGER $(cat $RICE/package-installation/default/pkgs-to-install_default.txt)
    fi
}

install_from_pkg_file INSTALLER "$TO_INSTALL" "$ALREADY_INSTALLED"

