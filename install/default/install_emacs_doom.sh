#!/bin/sh


# uninstall emacs
# TODO
# brew
    # brew uninstall --cask emacs
    # brew uninstall emacs
    # brew install --cask emacs
# or pacman
    # sudo pacman -R emacs
    # sudo pacman -S emacs

# install base emacs to ~/.emacs.d
if [[ -d $HOME/.emacs.d ]]; then
    echo "emacs config is already cloned to ~/.emacs.d"
else
    URL_TO_EMACS_REPO="https://github.com/vincentmader/doom-emacs"
    git clone --depth 1 $URL_TO_EMACS_REPO $HOME/.emacs.d >> /dev/null
fi

# install doom
~/.emacs.d/bin/doom install

# sync doom
~/.emacs.d/bin/doom sync

