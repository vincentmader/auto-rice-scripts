#!/bin/sh


for i in $(cat $RICE/install/node/pkg_list_node.txt); do
    npm install -g "$i";
done

