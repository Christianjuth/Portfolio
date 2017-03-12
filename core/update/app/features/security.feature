Feature: test security
  
Scenario: try and access /pages without permission
  Given on page "/settings"
  Then no text "Settings" on page
