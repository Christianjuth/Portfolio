Feature: unauthenticated user

Scenario: login user
  Given on page "/login"
  Then fill input "username" with "admin"
  Then fill input "password" with "password"
  Then click button "Login" on page
  Then click button "Logout" on page
  
Scenario: update user from /settings
  Given on page "/login"
  Then fill input "username" with "admin"
  Then fill input "password" with "password"
  Then click button "Login" on page
  Given on page "/settings"
  Then fill input "username" with "john"
  Then fill input "phone_number" with "1-(800)-000-0000"
  Then click button "Update User" on page
  Then click link "Resend Code" on page
  Given on page "/"
  Then text "Welcome, John" on page
  
Scenario: update user password from /settings
  Given on page "/login"
  Then fill input "username" with "admin"
  Then fill input "password" with "password"
  Then click button "Login" on page
  Given on page "/settings"
  Then fill input "new_password" with "newpassword"
  Then fill input "confirm_password" with "newpassword"
  Then click button "Update Password" on page
  Then click button "Logout" on page
  Given on page "/login"
  Then fill input "username" with "admin"
  Then fill input "password" with "newpassword"
  Then click button "Login" on page
  
  
Scenario: add, update, and delete api_verification
  Given on page "/login"
  Then fill input "username" with "admin"
  Then fill input "password" with "password"
  Then click button "Login" on page
  Given on page "/settings"
  Then click link "add" on page
  Then fill input "name" with "Google"
  Then fill input "key" with "123"
  Then fill input "secret" with "shhh"
  Then click button "Update" on page
  Then input "name" has value "Google"
  Then input "key" has value "123"
  Then input "secret" has value "shhh"
  Then click link "Delete" on page
  Then click button "Confirm Delete" on page
  
  
Scenario: add, update, and delete standard
  Given on page "/login"
  Then fill input "username" with "admin"
  Then fill input "password" with "password"
  Then click button "Login" on page
  Given on page "/standards"
  Then click link "add" on page
  Then fill input "title" with "Facebook Post"
  Then fill input "height" with "100"
  Then fill input "width" with "100"
  Then click button "Update" on page
  Then input "title" has value "Facebook Post"
  Then input "height" has value "100"
  Then input "width" has value "100"
  Then click link "Delete" on page
  Then click button "Confirm Delete" on page
  