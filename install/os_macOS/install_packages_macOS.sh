#!/bin/sh


# brew installs
# -----------------------------------------------------------------------------

# tap into brew package sources
for i in $(cat $RICE/install/os_macOS/pkg_list_brew_taps.txt); do
    brew tap "$i"
done

# install brew packages
brew install $(cat $RICE/install/os_macOS/pkg_list_brew.txt);

# install brew cask packages
brew install --cask $(cat $RICE/install/os_macOS/pkg_list_brew_cask.txt);


# macports installs
# -----------------------------------------------------------------------------

# install macports packages
for i in $(cat $RICE/install/os_macOS/pkg_list_macports.txt); do
    sudo port install "$i";   # TODO why?
done


# post-install configuration
# -----------------------------------------------------------------------------

# for mactex install:
eval "$(/usr/libexec/path_helper)"

