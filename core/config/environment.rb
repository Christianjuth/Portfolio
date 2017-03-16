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
  
  if defined?(SimpleCov) && defined?(Codacy)
    SimpleCov.start do
      add_filter "db/"
      add_filter "features/"
      add_filter "travis/"
      add_filter "node_modules/"
      add_filter "public/bower/"

      add_group 'Controllers', 'app/controllers'
      add_group 'Models', 'app/models'
      add_group 'Views', 'app/views'
    end
    if File.exist?(".github-token")
      Codacy::Reporter.start
    end
  end
end