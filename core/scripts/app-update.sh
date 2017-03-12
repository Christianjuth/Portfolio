#!/bin/bash

GREEN='\033[0;32m'
NC='\033[0m' # No Color
printf "${GREEN}Checking dependencies... ${NC}\n"

printf "\nGems:\n"
awk "/\*/" <<< "$(bundle outdated)"
printf "\nNode Modules:\n"
awk "/→/" <<< "$(./node_modules/.bin/npm-check-updates)"
printf "\nBower:\n"
awk "/→/" <<< "$(./node_modules/.bin/npm-check-updates -m bower)"
printf "\n"

mkdir core/update
cd core/update
curl -L http://github.com/Christianjuth/whatbywhat/archive/master.zip -o app.zip
unzip app -d extracted >/dev/null
rm app.zip
mv extracted/* app
rm -rf extracted