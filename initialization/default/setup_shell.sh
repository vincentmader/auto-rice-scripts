
echo_header_l2 "Setting up shell... (zsh)"

# chsh -s $(which zsh) 

$PACKAGE_MANAGER zsh
chsh -s /bin/zsh

# if [ ! "$OS" = "macOS"];then
# else
    # echo "Already installed. (git comes with Xcode)"  
# fi
