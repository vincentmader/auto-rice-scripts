#!/bin/sh


echo -e "$COLOR_BLUE\nInstalling git version control system...$COLOR_DEFAULT"

# exit if git is already installed
if command -v "git" &> /dev/null; then
    echo "Already installed."
else
    $PACKAGE_MANAGER git
fi


