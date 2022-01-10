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

# theme setup
PATH_TO_THEME="$HOME/.emacs.d/.local/straight/build-27.2/doom-themes/doom-solarized-dark-theme.el"
rm $PATH_TO_THEME
ln -s $HOME/.doom.d/lisp/themes/solarized-custom.el $PATH_TO_THEME

# sync doom
~/.emacs.d/bin/doom sync

