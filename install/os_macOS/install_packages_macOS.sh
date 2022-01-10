#!/bin/sh


# brew installs
# -----------------------------------------------------------------------------

# tap into brew package sources
echo "Tapping into macOS repositories using brew..."
for i in $(cat $RICE/install/os_macOS/pkg_list_brew_taps.txt); do
    brew tap "$i"
done

# install brew packages
echo "Installing macOS packages using brew..."
brew install $(cat $RICE/install/os_macOS/pkg_list_brew.txt);

# install brew cask packages
echo "Installing macOS packages using brew-cask..."
brew install --cask $(cat $RICE/install/os_macOS/pkg_list_brew_cask.txt);


# macports installs
# -----------------------------------------------------------------------------

# install macports packages
if [ $INSTALL_PKGS_MACPORTS = true ]; then
    echo "Installing macOS packages using macports..."
    for i in $(cat $RICE/install/os_macOS/pkg_list_macports.txt); do
        # echo "Please enter password for MacPorts installations."   # TODO
        sudo port install "$i"; 
    done
fi


# post-install configuration
# -----------------------------------------------------------------------------

# for mactex install:
eval "$(/usr/libexec/path_helper)"

