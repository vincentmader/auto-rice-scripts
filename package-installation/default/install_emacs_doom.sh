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
echo "Cloning emacs-doom..."
if [[ -d $HOME/.emacs.d ]]; then
    echo "  -> emacs config is already cloned to ~/.emacs.d"
else
    URL_TO_EMACS_REPO="https://github.com/vincentmader/doom-emacs"
    git clone --depth 1 $URL_TO_EMACS_REPO $HOME/.emacs.d >> /dev/null
fi

# install doom
echo -e "$COLOR_BLUE\nInstalling emacs-doom...$COLOR_DEFAULT"
~/.emacs.d/bin/doom install

# clone doom config
echo "Cloning emacs-doom-config..."
PATH_TO_DOOM="$HOME/.doom.d"
URL_TO_DOOM="https://github.com/vincentmader/doom-emacs-conf"
sudo rm -r $PATH_TO_DOOM
git clone $URL_TO_DOOM $PATH_TO_DOOM

# theme setup
PATH_TO_THEME="$HOME/.emacs.d/.local/straight/build-27.2/doom-themes/doom-solarized-dark-theme.el"
rm $PATH_TO_THEME
ln -s $HOME/.doom.d/lisp/themes/solarized-custom.el $PATH_TO_THEME

# sync doom
echo "Syncing emacs-doom..."
~/.emacs.d/bin/doom sync

