#!/bin/sh


echo "Installing node packages using npm..."

for i in $(cat $RICE/install/node/pkg_list_node.txt); do
    sudo npm install -g "$i";
done

