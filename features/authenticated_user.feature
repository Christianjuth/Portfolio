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
  Then text "WELCOME, JOHN" on page
  
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
  
Scenario: setup home page
  Given on page "/login"
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
  Given on page "/page/edit/1"
  Then input "title" has value "home"
  Then input "content" has value "Hello World!"
  
Scenario: setup another page
  Given on page "/login"
  Then fill input "username" with "admin"
  Then fill input "password" with "password"
  Then click button "Login" on page
  Given on page "/pages"
  Then click link "add" on page
  Then fill input "title" with "another"
  Then fill input "content" with "Welcome to another page!"
  Then click button "Update" on page
  Given on page "/page/another"
  Then text "Welcome to another page!" on page
  Given on page "/page/edit/1"
  Then input "title" has value "another"
  Then input "content" has value "Welcome to another page!"
  
Scenario: setup and delete page
  Given on page "/login"
  When button "Login" on page
  Then fill input "username" with "admin"
  Then fill input "password" with "password"
  Then click button "Login" on page
  Given on page "/pages"
  Then click link "add" on page
  Then click link "Delete" on page
  Then click button "Confirm Delete" on page
  
Scenario: setup and delete page from /pages
  Given on page "/login"
  Then fill input "username" with "admin"
  Then fill input "password" with "password"
  Then click button "Login" on page
  Given on page "/pages"
  Then click link "add" on page
  Given on page "/pages"
  Then click link "Delete" on page
  Then click button "Confirm Delete" on page
  
Scenario: create blog post
  Given on page "/login"
  Then fill input "username" with "admin"
  Then fill input "password" with "password"
  Then click button "Login" on page
  Given on page "/blog_posts"
  Then click link "add" on page
  Then fill input "title" with "Headline"
  Then fill input "content" with "Welcome to a blog post!"
  Then check input "publish"
  Then click button "Update" on page
  Given on page "/blog/1"
  Then text "Welcome to a blog post!" on page
  Given on page "/blog_post/edit/1"
  Then input "title" has value "Headline"
  Then input "content" has value "Welcome to a blog post!"
  
Scenario: setup and delete blog_post
  Given on page "/login"
  When button "Login" on page
  Then fill input "username" with "admin"
  Then fill input "password" with "password"
  Then click button "Login" on page
  Given on page "/blog_posts"
  Then click link "add" on page
  Then click link "Delete" on page
  Then click button "Confirm Delete" on page
  
Scenario: setup and blog post page from /blog_posts
  Given on page "/login"
  Then fill input "username" with "admin"
  Then fill input "password" with "password"
  Then click button "Login" on page
  Given on page "/blog_posts"
  Then click link "add" on page
  Given on page "/blog_posts"
  Then click link "Delete" on page
  Then click button "Confirm Delete" on page
  
Scenario: add and update portfolio entry
  Given on page "/login"
  Then fill input "username" with "admin"
  Then fill input "password" with "password"
  Then click button "Login" on page
  Given on page "/portfolio"
  Then click link "add" on page
  Then fill input "title" with "Project 1"
  Then fill input "color" with "#222222"
  Then fill input "blurb" with "Hello World!"
  Then fill input "description" with "This is a project."
  Then fill input "website" with "http://christianjuth.com"
  Then fill input "github" with "https://github.com/Christianjuth/Portfolio"
  Then click button "Update" on page
  Given on page "/portfolio"
  Then text "Project 1" on page
  Given on page "/portfolio/1"
  Then text "Project 1" on page
  Then text "This is a project." on page
  Given on page "/portfolio/edit/1"
  Then input "title" has value "Project 1"
  Then input "color" has value "#222222"
  Then input "blurb" has value "Hello World!"
  Then input "description" has value "This is a project."
  Then input "website" has value "http://christianjuth.com"
  Then input "github" has value "https://github.com/Christianjuth/Portfolio"
  
Scenario: add and delete portfolio entry
  Given on page "/login"
  Then fill input "username" with "admin"
  Then fill input "password" with "password"
  Then click button "Login" on page
  Given on page "/portfolio"
  Then click link "add" on page
  Then click link "Delete" on page
  Then click button "Confirm Delete" on page
  
Scenario: update invalid portfolio entry
  Given on page "/login"
  Then fill input "username" with "admin"
  Then fill input "password" with "password"
  Then click button "Login" on page
  Given on page "/portfolio"
  Then click link "add" on page
  Then fill input "title" with "Project 1"
  Then fill input "color" with "#22"
  Then fill input "blurb" with "Hello World!"
  Then fill input "description" with "This is a project."
  Then click button "Update" on page
  Then text "Error" on page
  
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
  
Scenario: submit, read, and delete message
  Given on page "/login"
  Then fill input "username" with "admin"
  Then fill input "password" with "password"
  Then click button "Login" on page
  Given on page "/"
  Then fill input "name" with "Tim Smith"
  Then fill input "email" with "timsmith101@gmail.com"
  Then fill input "fun_fact" with "I like trains!"
  Then fill input "message" with "How you doing man?"
  Then click button "Send" on page
  Given on page "/messages"
  Then click link "Read" on page
  Then click link "Delete" on page
  