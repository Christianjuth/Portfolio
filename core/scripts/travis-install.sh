#!/bin/bash

# Check if Qt installed
if ! type -P qmake &>/dev/null; then

  # Install Qt5
  # Mac
  if [ "$(uname)" == "Darwin" ]; then
    brew tap homebrew/versions
    brew install qt55
    brew link --force qt55
  # Linux
  elif [ "$(uname)" == "Linux" ]; then
    sudo apt-get install qt5-default libqt5webkit5-dev
    sudo apt-get install xvfb
    sudo su -c "gem install sass"
  fi
fi