#!/bin/sh


echo "$COLOR_BLUE\nInstalling system packages...$COLOR_DEFAULT"

# TODO rename PKG_MANAGER -> INSTALL_CMD
if [ "$PACKAGE_MANAGER" = "brew install" ]; then  
    cat "$RICE/install/default/pkg_list_default.txt" | while read line; do
        echo "  - $line"
        brew info "${line}" | 
        grep --quiet "Not installed" && 
        brew install "${line}"
    done
else 
    $PACKAGE_MANAGER $(cat $RICE/install/default/pkg_list_default.txt)
fi


