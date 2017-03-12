#!/bin/bash

bundle install --without production 
npm run app-migrate
npm run app-seed 
./node_modules/.bin/bower install 
./node_modules/.bin/grunt once