#!/bin/sh


echo "$COLOR_BLUE\nConfiguring zathura...$COLOR_DEFAULT"

mkdir -p $(brew --prefix zathura)/lib/zathura

rm $(brew --prefix zathura)/lib/zathura/libpdf-mupdf.dylib 2> /dev/null
ln -s $(brew --prefix zathura-pdf-mupdf)/libpdf-mupdf.dylib $(brew --prefix zathura)/lib/zathura/libpdf-mupdf.dylib

