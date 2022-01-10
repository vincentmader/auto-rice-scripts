#!/bin/sh


echo "Setting up xcode..."

xcodebuild -license accept
xcode-select --install

