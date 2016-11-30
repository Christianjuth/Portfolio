#!/bin/bash

if [ "$(uname)" == "Darwin" ]; then
  brew install qt
elif [ "$(uname)" == "Linux" ]; then
  sudo apt-get install libqtwebkit-dev
fi