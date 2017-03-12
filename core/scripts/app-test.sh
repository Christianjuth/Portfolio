#!/bin/bash

test=""
if [ "$1" != "" ]; then
  test="features/${1}.feature"
fi

GREEN='\033[0;32m'
NC='\033[0m' # No Color
printf "${GREEN}Starting test... ${NC}\n\n"

source ./core/scripts/npm-setup-codacy.sh

if [ "$(uname)" == "Darwin" ]; then
  bundle exec cucumber $test
elif [ "$(uname)" == "Linux" ]; then
  xvfb-run bundle exec cucumber $test
fi