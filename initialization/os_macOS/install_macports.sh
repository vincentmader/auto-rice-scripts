#!/bin/sh


echo -e "$COLOR_BLUE\nInstalling macports...$COLOR_DEFAULT"

# (re-)install macports
# -----------------------------------------------------------------------------

# exit if port is already installed
if command -v "port" &> /dev/null; then
    echo "Already installed."
    # uninstall all macports packages
        # sudo port -fp uninstall installed
    
    # delete macports users & groups
        # sudo dscl . -delete /Users/macports
        # sudo dscl . -delete /Groups/macports
    
    # remove the rest of macports
        # sudo rm -rf \
        #     /opt/local \
        #     /Applications/DarwinPorts \
        #     /Applications/MacPorts \
        #     /Library/LaunchDaemons/org.macports.* \
        #     /Library/Receipts/DarwinPorts*.pkg \
        #     /Library/Receipts/MacPorts*.pkg \
        #     /Library/StartupItems/DarwinPortsStartup \
        #     /Library/Tcl/darwinports1.0 \
        #     /Library/Tcl/macports1.0 \
        #     ~/.macports
else
    # move into src directory
    cd $RICE/src
    
    # download source & unpack to ./src directory  TODO make version-independent
    curl -O "https://distfiles.macports.org/MacPorts/MacPorts-2.7.1.tar.bz2"
    tar xf "MacPorts-2.7.1.tar.bz2"
    rm "MacPorts-2.7.1.tar.bz2"
    
    # install
    cd "./MacPorts-2.7.1/"
    ./configure
    make
    sudo make install 
    
    # update macports
    sudo port -v selfupdate
    
    # move back to rice-script root directory
    cd $RICE;
fi

