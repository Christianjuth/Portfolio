# The Portfolio of Christian Juth [![Build Status](https://travis-ci.org/Christianjuth/Portfolio.svg?branch=master)](https://travis-ci.org/Christianjuth/Portfolio) [![Stories in Ready](https://badge.waffle.io/Christianjuth/portfolio.svg?label=ready&title=Issues)](http://waffle.io/Christianjuth/sinatra-startpoint)

ChristianJuth.com is a Sinatra web app that incorporates GruntJS, TravisCI, and many other technologies to create a seamless development to production environment. Installing the project is as simple as cloning the git repo and running `npm install`. Once all the desired updates are made, the project is committed and pushed to Github. From there Travis picks up the commit, tests it using cucumber, and pushes it off to Heroku. This makes it very easy to allow other people to work on the project without having to learn how to use Heroku, and it ensures the application still works before it gets deployed.

### Behind the Scenes
ChristianJuth.com is a complex Sinatra application based on another project I created [Sinatra Start Point](https://github.com/Christianjuth/sinatra-start-point). Sinatra Start Point is the foundation for every Sinatra project I create. Currently, I have made a bunch of improvements to ChristianJuth.com that I intend to merge back into Sinatra Start Point. After every project I build I assess what makes it better than the last and merge that into Sinatra Start Point. This workflow ensures each project I create is better than the last.

# Getting Started
Clone the repository

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
