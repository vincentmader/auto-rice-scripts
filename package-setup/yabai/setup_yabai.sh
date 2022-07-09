#!/bin/sh

echo_header_l2 "Configuring yabai..."

# install the scripting addition
sudo yabai --install-sa

# if macOS Big Sur or Monterey, load the scripting addition manually; follow instructions below to automate on startup
sudo yabai --load-sa

