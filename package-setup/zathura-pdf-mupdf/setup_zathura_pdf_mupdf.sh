#!/bin/sh


echo_header_l2 "Configuring zathura..."

mkdir -p $(brew --prefix zathura)/lib/zathura

rm $(brew --prefix zathura)/lib/zathura/libpdf-mupdf.dylib 2> /dev/null
ln -s $(brew --prefix zathura-pdf-mupdf)/libpdf-mupdf.dylib $(brew --prefix zathura)/lib/zathura/libpdf-mupdf.dylib

echo "Configured zathura."

