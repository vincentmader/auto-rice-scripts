#!/bin/sh

if [ $OS = "macOS" ]; then
    echo "repo sync is done automatically on macOS (via iCloud)"
    exit 1
fi

# clone wallpapers
# sudo rm -r $CONF/symlinks/docs/wallpapers 2> /dev/null
git clone https://github.com/vincentmader/wallpapers $CONF/symlinks/docs/wallpapers

# TODO get code projects
git clone https://github.com/vincentmader/mader.xyz $CONF/symlinks/code/mader.xyz

# TODO get config somewhere else

