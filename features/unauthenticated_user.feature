Feature: unauthenticated user

Scenario: test home page
  Given on page "/"
  Then text "Contact" on page

Scenario: submit message on /
  Given on page "/"
  Then fill input "name" with "Tim Smith"
  Then fill input "email" with "timsmith101@gmail.com"
  Then fill input "fun_fact" with "I like trains!"
  Then fill input "message" with "How you doing man?"
  Then click button "Send" on page

Scenario: test portfolio page
  Given on page "/portfolio"
  Then text "Portfolio" on page
  
Scenario: test 404 page
  Given on page "/404"
  Then text "404" on page
  
Scenario: /home redirected to /
  Given on page "/home"
  Then current page "/"
  
Scenario: /does_not_exist verify 404
  Given on page "/does_not_exist"
  Then text "404" on page
  
Scenario: /portfolio/20 verify 404
  Given on page "/portfolio/20"
  Then text "404" on page