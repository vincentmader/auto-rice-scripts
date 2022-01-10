#!/bin/sh


echo "Installing oh-my-zsh & zsh plugins..."

# remove old oh-my-zsh files (if existent)
sudo rm -r $CONF/zsh/oh-my-zsh >> /dev/null;

# install oh-my-zsh package manager
export RUNZSH=no;
URL_TO_INSTALL="https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh"
sh -c "$(curl -fsSL $URL_TO_INSTALL)";

if [ "$OS" = "arch" ] && [ -d $HOME/.oh-my-zsh ]; then
    mv $HOME/.oh-my-zsh $CONF/zsh/oh-my-zsh
fi

# delete newly-created $HOME/.zshrc files (& use my own instead)
rm $HOME/.zshrc $HOME/.*.pre-oh-my-zsh* 2> /dev/null;
ln -s $CONF/zsh/zshrc $HOME/.zshrc

# install syntax highlighting
URL_TO_HIGHLIGHTING="https://github.com/zsh-users/zsh-syntax-highlighting.git"
PATH_TO_HIGHLIGHTING="$CONF/zsh/oh-my-zsh/plugins/zsh-syntax-highlighting"
git clone $URL_TO_HIGHLIGHTING $PATH_TO_HIGHLIGHTING;

