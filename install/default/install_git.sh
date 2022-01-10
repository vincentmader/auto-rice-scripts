#!/bin/sh


echo "Installing git..."

# exit if git is already installed
if command -v "git" &> /dev/null
then
    echo "  -> git is already installed!"
    exit
fi

$PACKAGE_MANAGER git

