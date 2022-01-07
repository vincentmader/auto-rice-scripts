#!/bin/sh


# remove old oh-my-zsh files (if existent)
sudo rm -r $CONF/zsh/oh-my-zsh >> /dev/null;

# install oh-my-zsh package manager
export RUNZSH=no;
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)";

# delete newly-created $HOME/.zshrc files (& use my own instead)
rm $HOME/.zshrc $HOME/.zshrc.pre-oh-my-zsh*;
ln -s $CONF/zsh/zshrc $HOME/.zshrc

# install syntax highlighting
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $CONF/zsh/oh-my-zsh/plugins/zsh-syntax-highlighting;

