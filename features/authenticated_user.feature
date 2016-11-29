Feature: unauthenticated user

Scenario: login user
  Given on page "/login"
  When button "Login" on page
  Then fill input "username" with "admin"
  Then fill input "password" with "password"
  Then click button "Login" on page
  
Scenario: setup home page
  Given on page "/login"
  When button "Login" on page
  Then fill input "username" with "admin"
  Then fill input "password" with "password"
  Then click button "Login" on page
  Given on page "/pages"
  Then click link "add" on page
  Then fill input "title" with "home"
  Then fill input "content" with "Hello World!"
  Then click button "Update" on page
  Given on page "/"
  Then text "Hello World!" on page
  
Scenario: add portfolio entry
  Given on page "/login"
  When button "Login" on page
  Then fill input "username" with "admin"
  Then fill input "password" with "password"
  Then click button "Login" on page
  Given on page "/portfolio"
  Then click link "add" on page
  Then fill input "title" with "Project 1"
  Then fill input "color" with "#222222"
  Then fill input "blurb" with "Hello World!"
  Then fill input "description" with "This is a project."
  Then click button "Update" on page
  Given on page "/portfolio"
  Then text "Project 1" on page
  Given on page "/portfolio/1"
  Then text "This is a project." on page