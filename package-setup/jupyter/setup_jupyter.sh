#!/bin/sh

echo_header_l2 "Configuring jupyter..."

# Create required directory in case (optional)
mkdir -p $(jupyter --data-dir)/nbextensions

# Clone the repository
cd $(jupyter --data-dir)/nbextensions
git clone https://github.com/lambdalisue/jupyter-vim-binding vim_binding
# Activate the extension
jupyter nbextension enable vim_binding/vim_binding

jt -t solarizedd  # NOTE run `jt -l` for list of available themes

cp "$RICE/package-setup/jupyter/jupyter.css" "$(jupyter --config-dir)/custom/custom.css"
