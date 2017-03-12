#!/bin/bash

GREEN='\033[0;32m'
NC='\033[0m' # No Color
printf "${GREEN}Updating dependencies... ${NC}\n"

printf "\nGems:\n"
printf "$(sed 's/Using/%2s%s*/g' <<< "$(awk "/Using/" <<< "$(bundle update)")")\n"
printf "\nNode Modules:\n"
awk "/→/" <<< "$(./node_modules/.bin/npm-check-updates -u)"
printf "\nBower:\n"
awk "/→/" <<< "$(./node_modules/.bin/npm-check-updates -m bower -u)"
bower update &> /dev/null
printf "\n"