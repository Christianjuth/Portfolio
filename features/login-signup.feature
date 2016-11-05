Feature: admin login

Scenario: login user
  Given on page "/login"
  When button "Login" on page
  Then fill input "username" with "admin"
  Then fill input "password" with "password"
  Then click button "Login" on page