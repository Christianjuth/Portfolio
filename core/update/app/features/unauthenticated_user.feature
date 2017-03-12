Feature: unauthenticated user

Scenario: test home page
  Given on page "/"
  Then no text "404" on page
  
Scenario: test 404 page
  Given on page "/404"
  Then text "404" on page
  
Scenario: /does_not_exist verify 404
  Given on page "/does_not_exist"
  Then text "404" on page
  
Scenario: test password reset link
  Given on page "/login"
  Then click link "Forgot Password?" on page
  Then fill input "username" with "admin"
  Then click button "Request Reset" on page
  
Scenario: test password reset
  Given table "password_resets" a record
    | user_id | 1                 |
    | token   | hsuUXUjPoV9At9Yuk |
  Given on page "/reset_password?id=1&token=hsuUXUjPoV9At9Yuk"
  Then fill input "new_password" with "password"
  Then fill input "confirm_password" with "password"
  Then click button "Reset" on page
  Then text "Welcome, Admin" on page