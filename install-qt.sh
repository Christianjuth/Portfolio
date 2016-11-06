if [ "$(uname)" == "Darwin" ]; then
  brew install qt
elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
  sudo apt-get update
  sudo apt-get install qt4-qmake libqt4-dev
fi