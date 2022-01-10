#!/bin/sh


echo "Installing system packages..."

$PACKAGE_MANAGER $(cat $RICE/install/default/pkg_list_default.txt)

