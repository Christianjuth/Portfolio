```             
 __    __  __ __   ____  ______      ____   __ __      __    __  __ __   ____  ______ 
|  |__|  ||  |  | /    ||      |    |    \ |  |  |    |  |__|  ||  |  | /    ||      |
|  |  |  ||  |  ||  o  ||      |    |  o  )|  |  |    |  |  |  ||  |  ||  o  ||      |
|  |  |  ||  _  ||     ||_|  |_|    |     ||  ~  |    |  |  |  ||  _  ||     ||_|  |_|
|  `  '  ||  |  ||  _  |  |  |      |  O  ||___, |    |  `  '  ||  |  ||  _  |  |  |  
 \      / |  |  ||  |  |  |  |      |     ||     |     \      / |  |  ||  |  |  |  |  
  \_/\_/  |__|__||__|__|  |__|      |_____||____/       \_/\_/  |__|__||__|__|  |__|  
                                                                                 
```
# A Project by Christian Juth

[![Build Status](https://travis-ci.org/Christianjuth/whatbywhat.svg?branch=master)](https://travis-ci.org/Christianjuth/whatbywhat) [![Dependency Status](https://gemnasium.com/badges/github.com/Christianjuth/whatbywhat.svg)](https://gemnasium.com/github.com/Christianjuth/whatbywhat) [![Greenkeeper badge](https://badges.greenkeeper.io/Christianjuth/whatbywhat.svg)](https://greenkeeper.io/) [![Codacy Badge](https://api.codacy.com/project/badge/Grade/bf691912f95e4bddae2ca4aa716eb875)](https://www.codacy.com/app/cjuth2/whatbywhat?utm_source=github.com&amp;utm_medium=referral&amp;utm_content=Christianjuth/whatbywhat&amp;utm_campaign=Badge_Grade)

### Quickstart Guide

##### 1. Get the Code
Clone the repository

##### 2. Setup environment
Requirements
* [Ruby v2](https://rvm.io/) _(via RVM recommended)_
* [Bundler](http://bundler.io/)
* [NodeJS](https://nodejs.org/en/)

```shell
  # install node modules and gems
  npm install
```
_No need to run `bundle install`, npm postinstall handels that._

##### 3. Running the Project
```shell
  # starts the development server on port 3000
  npm start
```

(click control c to quit)

### Database
```shell
  # migrate database
  npm run app-migrate
  
  # seed database
  npm run app-seed
```

### Testing
Create a file in the root of the repository called `.github-token` and paste your Github token inside. This will enable Codacy coverage.

```shell
  # test using mocha
  npm test
```

### All Commands
```shell
  # shortcuts
  npm start
  npm stop
  npm test
  
  # full commands
  npm run app-start
  npm run app-stop
  npm run app-test
  npm run app-update
  npm run app-upgrade
  npm run app-migrate
  npm run app-seed
```