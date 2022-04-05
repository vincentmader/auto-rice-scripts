#!/bin/sh


function install_from_pkg_file {

    TO_INSTALL="$2"
    ALREADY_INSTALLED="$3"

    if [[ ! -f "$ALREADY_INSTALLED" ]]; then
        touch "$ALREADY_INSTALLED"
    fi

    grep -v '^#' $TO_INSTALL | while read line; do
        if grep -Fxq "$line" "$ALREADY_INSTALLED"; then
            printc "** $line\n"
        else 
            printc "++ $line\n" "$COLOR_GREEN"
            $1 "$line"  # run installer-function passed as 1st argument
            echo "$line" >> "$ALREADY_INSTALLED"
        fi
    done
}
export -f install_from_pkg_file

