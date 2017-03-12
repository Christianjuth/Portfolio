#!/bin/bash

kill -9 $(lsof -i tcp:3000 | tail -n 1 | perl -lne 'print $& if /(?<=ruby)\\s+[0-9]+/i') >/dev/null 2>&1 &