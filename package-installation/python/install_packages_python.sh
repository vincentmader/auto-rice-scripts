#!/bin/sh


# UPGRADING PIP3
# -----------------------------------------------------------------------------            

printc "Upgrading pip3...\n$SEPARATOR_1"

if [[ "$OS" = "macOS" ]]; then
    brew upgrade python
else 
    pip3 install --upgrade pip
fi

# INSTALLING PYTHON PACKAGES
# -----------------------------------------------------------------------------            

printc "Installing python packages using pip3...\n$SEPARATOR_1"

TO_INSTALL="$RICE/package-installation/python/pkgs_python/to-install.txt"
ALREADY_INSTALLED="$RICE/package-installation/python/pkgs_python/installed.txt"

function INSTALLER() {
    pip3 install "$1"
}

install_from_pkg_file INSTALLER "$TO_INSTALL" "$ALREADY_INSTALLED"

# TODO install torch (not available for python 10)
# pip install torch===1.4.0 torchvision===0.5.0 -f https://download.pytorch.org/whl/torch_stable.html

