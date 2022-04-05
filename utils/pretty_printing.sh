#!/bin/sh


# make `echo` behave the same on Arch and macOS
if [ "$OS" = "arch" ] ; then
    alias echo="echo -e"
fi

# re-define printf, but with color
function printc {
    MSG="$1"
    if [ $# -eq 1 ]; then
        COLOR="$COLOR_BLUE"
    elif [ $# -eq 2 ]; then
        COLOR="$2"
    fi
    printf "$COLOR$MSG$COLOR_DEFAULT"
}
export -f printc

# define a function to `echo` a commented separator/underline
function echo_separator {
    CHAR="$1"
    SEPARATOR=""
    for (( col_idx=1; col_idx<=$(tput cols); col_idx++ )); do
        SEPARATOR="$SEPARATOR$CHAR"
    done
    echo "$SEPARATOR"
}
export SEPARATOR_1=$(echo_separator "-")
export SEPARATOR_2=$(echo_separator "=")

# define level-0 header
function echo_header_l0 {
    # ----------------------
    # MSG
    # ----------------------
    #
    printc "\n$SEPARATOR_1\n$1\n$SEPARATOR_1\n"
}
export -f echo_header_l0

# define level-1 header
function echo_header_l1 {
    #
    # ======================
    # MSG
    # ======================
    #
    #
    printc "\n\n$SEPARATOR_2\n$1\n$SEPARATOR_2\n\n"
}
export -f echo_header_l1

# define level-2 header
function echo_header_l2 {
    # MSG
    # ----------------------
    #
    printc "\n$1\n$SEPARATOR_1\n"
}
export -f echo_header_l2

# define level-3 header
function echo_header_l3 {
    # MSG
    # 
    printc "\n$1\n"
}
export -f echo_header_l3

# define title
function echo_title {
    MSG="$PROJECT_NAME"
    START_IDX=0
    END_IDX=$(( $(tput cols) - ${#PROJECT_NAME} - ${#AUTHOR} - 1 ))
    for (( col_idx=$START_IDX; col_idx<=$END_IDX; col_idx++ )); do
        MSG="$MSG "
    done
    MSG="$MSG$AUTHOR"

    echo_header_l0 "$MSG"
}

