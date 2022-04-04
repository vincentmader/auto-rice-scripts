#!/bin/sh


printc "Setting up xcode..."

xcodebuild -license accept
xcode-select --install

