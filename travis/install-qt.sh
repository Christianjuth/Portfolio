#!/bin/bash

if [ "$(uname)" == "Darwin" ]; then
  brew install qt
elif [ "$(uname)" == "Linux" ]; then
  sudo apt-get update
  sudo apt-get install libqt4pas
fi