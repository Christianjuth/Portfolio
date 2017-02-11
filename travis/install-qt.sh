#!/bin/bash

if [ "$(uname)" == "Darwin" ]; then
  brew tap homebrew/versions
  brew install qt
  brew link --force qt
elif [ "$(uname)" == "Linux" ]; then
  sudo apt-get install libqt4-dev libqtwebkit-dev
fi