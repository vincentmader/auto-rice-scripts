#!/bin/sh


echo "Installing ranger plugins..."

sudo rm -r $CONF/ranger/plugins/ranger_devicons >> /dev/null
URL_TO_ICONS="https://github.com/alexanderjeurissen/ranger_devicons.git"
git clone $URL_TO_ICONS $CONF/ranger/plugins/ranger_devicons

