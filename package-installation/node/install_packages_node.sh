#!/bin/sh


printc "Installing node packages using npm...\n$SEPARATOR_1"

TO_INSTALL="$RICE/package-installation/node/pkgs_node/to-install.txt"
ALREADY_INSTALLED="$RICE/package-installation/node/pkgs_node/installed.txt"

function INSTALLER() {
    sudo npm install -g "$1";
}
install_from_pkg_file INSTALLER "$TO_INSTALL" "$ALREADY_INSTALLED"

