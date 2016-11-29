Feature: unauthenticated user

Scenario: test portfolio page
  Given on page "/portfolio"
  Then text "Portfolio" on page
  
Scenario: test 404 page
  Given on page "/404"
  Then text "404" on page
  