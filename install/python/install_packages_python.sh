#!/bin/sh


pip3 install --upgrade pip
pip3 install -r $RICE/install/python/pkg_list_python.txt 

# TODO install torch (not available for python 10)
# pip install torch===1.4.0 torchvision===0.5.0 -f https://download.pytorch.org/whl/torch_stable.html

