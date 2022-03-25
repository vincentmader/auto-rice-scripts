#!/bin/sh


echo "Performing macOS command-line-tool update"

sudo rm -rf /Library/Developer/CommandLineTools
sudo xcode-select --install

