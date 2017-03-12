#!/bin/bash

GREEN='\033[0;32m'
NC='\033[0m' # No Color
printf "${GREEN}Starting test... ${NC}\n\n"

source ./lib/scripts/npm-setup-codacy.sh

if [ "$(uname)" == "Darwin" ]; then
  bundle exec cucumber
elif [ "$(uname)" == "Linux" ]; then
  xvfb-run bundle exec cucumber
fi