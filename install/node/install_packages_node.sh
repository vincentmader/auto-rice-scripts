#!/bin/sh


echo "$COLOR_BLUE\nInstalling node packages using npm...$COLOR_DEFAULT"

for i in $(cat $RICE/install/node/pkg_list_node.txt); do
    sudo npm install -g "$i";
done

