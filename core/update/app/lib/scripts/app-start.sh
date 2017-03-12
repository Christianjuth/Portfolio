#!/bin/bash

nohup grunt >/dev/null 2>&1 &

GREEN='\033[0;32m'
NC='\033[0m' # No Color
printf "${GREEN}Development server started: ${NC} <http://127.0.0.1:3000>\n"

thin start -p 3000 >/dev/null 2>&1