#!/bin/sh


# UPGRADING PIP3
echo "$COLOR_BLUE\nUpgrading pip3...$COLOR_DEFAULT"
echo_separator_1

pip3 install --upgrade pip


# INSTALLING PYTHON PACKAGES
echo "$COLOR_BLUE\nInstalling python packages using pip3...$COLOR_DEFAULT"
echo_separator_1

TO_INSTALL="$RICE/package-installation/python/pkgs_python/to-install.txt"
ALREADY_INSTALLED="$RICE/package-installation/python/pkgs_python/to-install.txt"

function INSTALLER() {
    pip3 install "$1"
}

install_from_pkg_file INSTALLER "$TO_INSTALL" "$ALREADY_INSTALLED"

# TODO install torch (not available for python 10)
# pip install torch===1.4.0 torchvision===0.5.0 -f https://download.pytorch.org/whl/torch_stable.html

