Feature: test security

Scenario: try and access /pages without permission
  Given on page "/pages"
  Then no text "Pages" on page
  
Scenario: try and access /pages without permission
  Given on page "/settings"
  Then no text "Settings" on page
  
Scenario: try and access /portfolio/edit without permission
  Given table "portfolio_entry" a record
    | description | Hello World! |
  Given on page "/portfolio/1"
  Then text "Hello World!" on page
  Given on page "/portfolio/edit/1"
  Then text "404" on page
  
Scenario: try and access /pages without permission
  Given on page "/settings"
  Then no text "settings" on page
  
Scenario: try and access /page/edit without permission
  Given table "pages" a record
    | title   | about             |
    | content | This is a page. |
  Given on page "/page/about"
  Then text "This is a page." on page
  Given on page "/portfolio/edit/1"
  Then text "404" on page
