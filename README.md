```
 _____ _          _     _   _               ___       _   _                          
/  __ \ |        (_)   | | (_)             |_  |     | | | |                         
| /  \/ |__  _ __ _ ___| |_ _  __ _ _ __     | |_   _| |_| |__    ___ ___  _ __ ___  
| |   | '_ \| '__| / __| __| |/ _` | '_ \    | | | | | __| '_ \  / __/ _ \| '_ ` _ \ 
| \__/\ | | | |  | \__ \ |_| | (_| | | | /\__/ / |_| | |_| | | || (_| (_) | | | | | |
 \____/_| |_|_|  |_|___/\__|_|\__,_|_| |_\____/ \__,_|\__|_| |_(_)___\___/|_| |_| |_|
                                                                                 
```

# The Portfolio of Christian Juth [![Build Status](https://travis-ci.org/Christianjuth/Portfolio.svg?branch=master)](https://travis-ci.org/Christianjuth/Portfolio) [![Stories in Ready](https://badge.waffle.io/Christianjuth/portfolio.svg?label=ready&title=Issues)](http://waffle.io/Christianjuth/sinatra-startpoint) [![Codacy Badge](https://api.codacy.com/project/badge/Grade/3e5abf687cfc495a93cafd274074fa39)](https://www.codacy.com/app/cjuth2/Portfolio?utm_source=github.com&amp;utm_medium=referral&amp;utm_content=Christianjuth/Portfolio&amp;utm_campaign=Badge_Grade)

[![Greenkeeper badge](https://badges.greenkeeper.io/Christianjuth/portfolio.svg)](https://greenkeeper.io/)

ChristianJuth.com is a Sinatra web app that incorporates GruntJS, TravisCI, and many other technologies to create a seamless development to production environment. Installing the project is as simple as cloning the git repo and running `npm install`. Once all the desired updates are made, the project is committed and pushed to Github. From there Travis picks up the commit, tests it using cucumber, and pushes it off to Heroku. This makes it very easy to allow other people to work on the project without having to learn how to use Heroku, and it ensures the application still works before it gets deployed.

### Behind the Scenes
ChristianJuth.com is a complex Sinatra application based on another project I created [Sinatra Start Point](https://github.com/Christianjuth/sinatra-start-point). Sinatra Start Point is the foundation for every Sinatra project I create. Currently, I have made a bunch of improvements to ChristianJuth.com that I intend to merge back into Sinatra Start Point. After every project I build I assess what makes it better than the last and merge that into Sinatra Start Point. This workflow ensures each project I create is better than the last.

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
  
  # or
  npm start port
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
Create a file in the root of the repository called `.codacy-token` and paste your Github token inside. This will enable Codacy coverage.

```shell
  # test using mocha
  npm test
  
  # or
  npm test specific_feature
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
  
  # upgrade Apollo
  npm run apollo-upgrade
```