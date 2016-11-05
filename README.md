# The Portfolio of Christian Juth [![Build Status](https://travis-ci.org/Christianjuth/Portfolio.svg?branch=master)](https://travis-ci.org/Christianjuth/Portfolio) [![Stories in Ready](https://badge.waffle.io/Christianjuth/portfolio.svg?label=ready&title=Issues)](http://waffle.io/Christianjuth/sinatra-startpoint)

### Setup environment
Requirements
* [Ruby v2 and Rubygems](https://rvm.io/) _(via RVM recommended)_
* [Bundler](http://bundler.io/)
* [NodeJS & NPM](https://nodejs.org/en/)
* [GruntJS](http://gruntjs.com)
* [Bower](http://bower.io/)

```shell
  # install node modules and gems
  npm install
```
_This command runs `bundle install` so you do not have to run that yourself._

### Running Sinatra
```shell
  # this command starts shotgun on port 3000
  npm start

  # this command force stops shotgun
  npm stop
```

### Database
```shell
  # migrate database
  npm run migrate
```

### Compiling
```shell
  # compile once
  grunt once

  # continuous compiling
  grunt
```

### Testing
```
  # test using mocha
  npm test
```
