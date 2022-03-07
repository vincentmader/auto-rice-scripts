#!/bin/sh


echo "$COLOR_BLUE\nInstalling python packages using pip3...$COLOR_DEFAULT"

PKG_FILE="$RICE/install/python/pkg_list_python.txt"

pip3 install --upgrade pip
pip3 install -r $PKG_FILE | grep -v "already satisfied"

# TODO install torch (not available for python 10)
# pip install torch===1.4.0 torchvision===0.5.0 -f https://download.pytorch.org/whl/torch_stable.html

