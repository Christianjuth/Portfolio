Feature: unauthenticated user

Scenario: test portfolio page
  Given on page "/portfolio"
  Then text "Portfolio" on page
  
Scenario: test 404 page
  Given on page "/404"
  Then text "404" on page
  
Scenario: /page/home redirected to /
  Given on page "/page/home"
  Then current page "/"
  
Scenario: /page/does_not_exist verify 404
  Given on page "/page/does_not_exist"
  Then text "404" on page
  
Scenario: /portfolio/20 verify 404
  Given on page "/portfolio/20"
  Then text "404" on page