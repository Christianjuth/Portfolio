if [ "$(uname)" == "Darwin" ]; then
  brew install qt
elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
  sudo apt-get update
  sudo apt-get install libqt4pas
fi