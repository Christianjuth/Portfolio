#!/bin/bash

if [ "$(uname)" == "Darwin" ]; then
  brew tap homebrew/versions
  brew install qt55
  brew link --force qt55
elif [ "$(uname)" == "Linux" ]; then
  sudo apt-get install qt5-default libqt5webkit5-dev
  sudo apt-get install xvfb
  sudo su -c "gem install sass"
fi