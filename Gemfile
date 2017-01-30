source "https://rubygems.org"
ruby "2.4.0"

gem "sinatra"
gem "activerecord"
gem "sinatra-activerecord"
gem "rake"
gem "bcrypt"
gem "json"
gem "sinch_sms"
gem "database_cleaner"
gem "rdiscount"
gem "recaptcha"
gem "imgkit"
gem "cloudinary"
require "rss"

group :development, :test do
  gem "shotgun"
  gem "pry"
  gem "tux"
  gem "sqlite3"
  gem "sass"
end

group :test do
  gem "cucumber"
  gem "capybara", require: "capybara/cucumber"
  gem "capybara-screenshot", require: "capybara-screenshot/cucumber"
  gem "capybara-webkit"
  gem "minitest", require: "minitest/spec"
  gem "codacy-coverage"
  gem "simplecov"
end

group :production do
  gem "pg"
end