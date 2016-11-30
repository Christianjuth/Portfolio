ENV["RACK_ENV"] = "test"

require "bundler"
require "sinatra"
Bundler.require(:default, Sinatra::Application.environment)
require "#{Dir.pwd}/db/seeds"

# Load Rake and Migrate Database
rake = Rake::Application.new
Rake.application = rake
rake.init
rake.load_rakefile

require_relative "../../app/controllers/application_controller"

Capybara::Webkit.configure do |config|
  config.allow_url("cdnjs.cloudflare.com")
  config.allow_url("referrer.disqus.com")
  config.allow_unknown_urls
end

Capybara::Webkit.configure do |config|
    
  end
Capybara::Screenshot.autosave_on_failure = true
Capybara::Screenshot.prune_strategy = :keep_last_run
Capybara::Screenshot.webkit_options = { width: 1024, height: 768 }
Capybara.save_path = "../screenshots/"
Capybara.default_wait_time = 10

class MinitestWorld
  extend Minitest::Assertions
  attr_accessor :assertions

  def initialize
    self.assertions = 0
  end
end
 
World do
  DatabaseCleaner.strategy = :truncation
  DatabaseCleaner.clean
  seed()
  
  MinitestWorld.new
  Capybara.app = ApplicationController
end