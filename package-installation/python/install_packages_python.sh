#!/bin/sh


# UPGRADING PIP3
# -----------------------------------------------------------------------------            

echo_header_l2 "Upgrading pip3..."

if [[ "$OS" = "macOS" ]]; then
    brew upgrade python
else 
    pip3 install --upgrade pip
fi

# INSTALLING PYTHON PACKAGES
# -----------------------------------------------------------------------------            

echo_header_l2 "Installing python packages using pip3..."

TO_INSTALL="$RICE/package-installation/python/pkgs_python/to-install.txt"
ALREADY_INSTALLED="$RICE/package-installation/python/pkgs_python/installed.txt"

function INSTALLER() {
    pip3 install "$1"
}

install_from_pkg_file INSTALLER "$TO_INSTALL" "$ALREADY_INSTALLED"

# TODO install torch (not available for python 10)
# pip install torch===1.4.0 torchvision===0.5.0 -f https://download.pytorch.org/whl/torch_stable.html

