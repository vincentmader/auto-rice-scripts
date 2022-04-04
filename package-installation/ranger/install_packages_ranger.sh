#!/bin/sh


printc "Installing ranger plugins...\n$SEPARATOR_1"
PATH_TO_RANGER_PLUGINS="$CONF/ranger/plugins"

# ranger-devicons
# -----------------------------------------------------------------------------

echo -e "$COLOR_BLUE**$COLOR_DEFAULT ranger-devicons"
PATH_TO_RANGER_DEVICONS="$PATH_TO_RANGER_PLUGINS/ranger_devicons"
if [ -d $PATH_TO_RANGER_DEVICONS ]; then
    cd $PATH_TO_RANGER_DEVICONS
    git pull
else
    URL_TO_ICONS="https://github.com/alexanderjeurissen/ranger_devicons.git"
    git clone $URL_TO_ICONS $CONF/ranger/plugins/ranger_devicons
fi


