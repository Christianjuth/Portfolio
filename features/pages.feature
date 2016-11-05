Feature: pages

Scenario: test 404 page
  Given on page "/404"
  Then text "404" on page