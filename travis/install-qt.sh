#!/bin/bash

if [ "$(uname)" == "Darwin" ]; then
  brew install qt
  brew install Caskroom/cask/wkhtmltopdf
elif [ "$(uname)" == "Linux" ]; then
  sudo apt-get install libqt4-dev libqtwebkit-dev
fi