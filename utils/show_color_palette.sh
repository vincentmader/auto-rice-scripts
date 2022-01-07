#!/bin/sh


for i in {0..255}; do  

    # print "colorX" in color X
    printf "\x1b[38;5;${i}mcolor%-5i\x1b[0m" $i ; 

    # add newline every 8 colors
    if ! (( ($i + 1 ) % 8 )); then 
        echo; 
    fi; 

done

