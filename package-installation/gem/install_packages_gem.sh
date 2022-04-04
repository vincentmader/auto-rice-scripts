#!/bin/sh


echo -e "$COLOR_BLUE\nInstalling ruby packages (gems)...$COLOR_DEFAULT"

TO_INSTALL="$RICE/package-installation/gem/pkgs_gem/to-install.txt"
ALREADY_INSTALLED="$RICE/package-installation/gem/pkgs_gem/installed.txt"

function INSTALLER {
    sudo gem install "$1"
}

install_from_pkg_file INSTALLER "$TO_INSTALL" "$ALREADY_INSTALLED"

