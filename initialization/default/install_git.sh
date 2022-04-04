#!/bin/sh


printc "Installing git version control system..."

# exit if git is already installed
if command -v "git" &> /dev/null; then
    echo "Already installed."
else
    $PACKAGE_MANAGER git
fi


