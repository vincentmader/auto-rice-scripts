#!/bin/sh


sudo rm -r $CONF/ranger/plugins/ranger_devicons >> /dev/null
git clone https://github.com/alexanderjeurissen/ranger_devicons.git $CONF/ranger/plugins/ranger_devicons

