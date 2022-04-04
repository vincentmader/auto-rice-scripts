#!/bin/sh


echo "$COLOR_BLUE\nInstalling arch-specific packages...$COLOR_DEFAULT"

TO_INSTALL="$RICE/package-installation/os_arch/pkgs_arch/to-install.txt"

# ALREADY_INSTALLED="$RICE/package-installation/os_arch/pkgs_arch/installed.txt"
# function INSTALLER {
#     $PACKAGE_MANAGER "$1"
#     # $PACKAGE_MANAGER $(cat $RICE/package-installation/os_arch/pkgs-to-install_arch.txt)
# }

$PACKAGE_MANAGER $(cat $TO_INSTALL)

# TODO skip already installed?

