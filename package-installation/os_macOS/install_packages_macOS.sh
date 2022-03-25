#!/bin/sh


PATH_TO_MACOS_INSTALLERS="$RICE/package-installation/os_macOS"


# brew installs
# -----------------------------------------------------------------------------

# tap into brew package sources
echo "$COLOR_BLUE\nTapping into macOS-specific repositories using brew...$COLOR_DEFAULT\n$SEPARATOR_1"
TO_INSTALL="$PATH_TO_MACOS_INSTALLERS/pkgs_brew-taps/to-install.txt"
ALREADY_INSTALLED="$PATH_TO_MACOS_INSTALLERS/pkgs_brew-taps/installed.txt"
function INSTALLER() {
    brew tap "$1"
}
install_from_pkg_file INSTALLER "$TO_INSTALL" "$ALREADY_INSTALLED"

# install brew packages   # TODO write function for this! (change path for installed)
echo "$COLOR_BLUE\nInstalling macOS-specific packages using brew...$COLOR_DEFAULT\n$SEPARATOR_1"
TO_INSTALL="$PATH_TO_MACOS_INSTALLERS/pkgs_brew/to-install.txt"
ALREADY_INSTALLED="$PATH_TO_MACOS_INSTALLERS/pkgs_brew/installed.txt"
function INSTALLER {
    brew info "$1" | grep --quiet "Not installed" && 
    brew install "$1"
}
install_from_pkg_file INSTALLER "$TO_INSTALL" "$ALREADY_INSTALLED"

# # install brew cask packages
echo "$COLOR_BLUE\nInstalling macOS-specific packages using brew-cask...$COLOR_DEFAULT\n$SEPARATOR_1"
TO_INSTALL="$PATH_TO_MACOS_INSTALLERS/pkgs_brew-cask/to-install.txt"
ALREADY_INSTALLED="$PATH_TO_MACOS_INSTALLERS/pkgs_brew-cask/installed.txt"
function INSTALLER {
    brew info "$1" | grep --quiet "Not installed" && 
    brew install --cask "$1"
}
install_from_pkg_file INSTALLER "$TO_INSTALL" "$ALREADY_INSTALLED"


# macports installs
# -----------------------------------------------------------------------------

# install macports packages
echo "$COLOR_BLUE\nInstalling macOS-specific packages using mac-ports...$COLOR_DEFAULT\n$SEPARATOR_1"
TO_INSTALL="$PATH_TO_MACOS_INSTALLERS/pkgs_macports/to-install.txt"
ALREADY_INSTALLED="$PATH_TO_MACOS_INSTALLERS/pkgs_macports/installed.txt"
function INSTALLER {
    # echo "Please enter password for MacPorts installations."   # TODO
    sudo port install "$i"; 
}
install_from_pkg_file INSTALLER "$TO_INSTALL" "$ALREADY_INSTALLED"


# install servo-browser  TODO
# -----------------------------------------------------------------------------
# git clone https://github.com/servo/servo "$SRC/servo"
# cd "$SRC/servo"
# brew bundle install --file=etc/taskcluster/macos/Brewfile
# brew bundle install --file=etc/taskcluster/macos/Brewfile-build
# pip install virtualenv
# ./mach bootstrap

