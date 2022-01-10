#!/bin/sh


echo "Configuring git..."

# setup git-commit username & email address
git config --global user.name "Vincent C. Mader"
git config --global user.email "vincent@mader.xyz"

# setup auto-saving of git-server credentials
if [[ "$OSTYPE" == "darwin"* ]]; then

    # auto-save creds to iCloud key-chain
    git config --global credential.helper cache  # -> select "always-allow"

elif [[ "$OSTYPE" == "linux"* ]]; then

    # auto-save credentials on disk (in plain-text !)
    git config --global credential.helper store

fi

# increase upload buffer size
git config http.postBuffer 524288000

