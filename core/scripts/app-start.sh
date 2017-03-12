#!/bin/bash

nohup grunt >/dev/null 2>&1 &

port=3000
if [ "$1" != "" ]; then
  port=${1}
fi

GREEN='\033[0;32m'
NC='\033[0m' # No Color
printf "${GREEN}Development server started: ${NC} <http://127.0.0.1:${port}>\n"

thin start -p $port >/dev/null 2>&1