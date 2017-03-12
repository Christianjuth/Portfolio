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