source "https://rubygems.org"
ruby "2.3.1"

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
  gem "tty"
  gem "github_api", ">=0.14.5"
  gem "simplecov"
  gem "codacy-coverage"
  gem "tux"
  gem "sqlite3"
  gem "sass"
  gem "sinatra-contrib", require: "sinatra/reloader"
  gem "thin"
end

group :test do
  gem "cucumber"
  gem "capybara", :require => false
  gem "capybara-screenshot", :require => false
  gem "capybara-webkit"
  gem "minitest", require: "minitest/spec"
end

group :production do
  gem "pg"
end