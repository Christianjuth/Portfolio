#!/bin/bash

if [ "$(uname)" == "Darwin" ]; then
  brew tap homebrew/versions
  brew install qt55
  brew link --force qt55
elif [ "$(uname)" == "Linux" ]; then
  sudo apt-get install libqt4-dev libqtwebkit-dev
fi