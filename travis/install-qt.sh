#!/bin/bash

if [ "$(uname)" == "Darwin" ]; then
  echo 'export PATH="/usr/local/opt/qt5/bin:$PATH"' >> ~/.bash_profile
  brew install qt
elif [ "$(uname)" == "Linux" ]; then
  sudo apt-get install libqt4-dev libqtwebkit-dev
fi