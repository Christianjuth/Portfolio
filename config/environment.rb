require "bundler"
require "sinatra"
Bundler.require(:default, Sinatra::Application.environment)

configure :development do
  set :db_adapter, "sqlite3"
  set :db_location, "db/website.db"
end

configure :test do
  set :db_adapter, "sqlite3"
  set :db_location, "db/cucumber-test.db"
  SimpleCov.start
  puts "required simplecov"
end