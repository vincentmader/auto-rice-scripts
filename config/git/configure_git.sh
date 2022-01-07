#!/bin/sh


# setup git-commit username & email address
git config --global user.name "Vincent C. Mader"
git config --global user.email "vincent@mader.xyz"

# setup auto-saving of git-server credentials
if [[ "$OSTYPE" == "darwin"* ]]; then

    # auto-save creds to iCloud key-chain
    git config --global credential.helper cache

elif [[ "$OSTYPE" == "linux"* ]]; then

    # auto-save credentials on disk (in plain-text !)
    git config --global credential.helper store

fi

