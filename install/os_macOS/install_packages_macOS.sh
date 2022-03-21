#!/bin/sh


# brew installs
# -----------------------------------------------------------------------------

# tap into brew package sources
echo "$COLOR_BLUE\nTapping into macOS-specific repositories using brew...$COLOR_DEFAULT"
for line in $(cat $RICE/install/os_macOS/pkg_list_brew_taps.txt); do
    echo "  - $line"
    brew tap "$line"
done

# install brew packages
echo "$COLOR_BLUE\nInstalling macOS-specific packages using brew...$COLOR_DEFAULT"
cat "$RICE/install/os_macOS/pkg_list_brew.txt" | while read line; do
    echo "  - $line"
    brew info "${line}" | grep --quiet "Not installed" && 
    brew install "${line}"
done

# install brew cask packages
echo "$COLOR_BLUE\nInstalling macOS-specific packages using brew-cask...$COLOR_DEFAULT"
cat "$RICE/install/os_macOS/pkg_list_brew_cask.txt" | while read line; do
    echo "  - $line"
    brew info "${line}" | grep --quiet "Not installed" && 
    brew install --cask "${line}"
done


# macports installs
# -----------------------------------------------------------------------------

# install macports packages
if [ $INSTALL_PKGS_MACPORTS = true ]; then
    echo "$COLOR_BLUE\nInstalling macOS packages using macports...$COLOR_DEFAULT"
    for i in $(cat $RICE/install/os_macOS/pkg_list_macports.txt); do
        # echo "Please enter password for MacPorts installations."   # TODO
        sudo port install "$i"; 
    done
fi


# post-install configuration
# -----------------------------------------------------------------------------

# for mactex install:
eval "$(/usr/libexec/path_helper)"

