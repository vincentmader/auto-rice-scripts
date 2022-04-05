#!/bin/sh


echo_header_l2 "Installing ranger plugins..."
PATH_TO_PLUGINS="$CONF/ranger/plugins"

# ranger-devicons
# -----------------------------------------------------------------------------

PATH_TO_ICONS="$PATH_TO_PLUGINS/ranger_devicons"
if [ -d $PATH_TO_ICONS ]; then
    printc "** ranger-devicons\n"
    cd $PATH_TO_ICONS && git pull
else
    printc "++ ranger-devicons\n" "$COLOR_GREEN"
    URL_TO_ICONS="https://github.com/alexanderjeurissen/ranger_devicons.git"
    git clone $URL_TO_ICONS $PATH_TO_ICONS
fi


