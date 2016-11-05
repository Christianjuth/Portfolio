ENV["RACK_ENV"] = "test"

require_relative "../../app/controllers/application_controller"

Capybara::Webkit.configure do |config|
  config.allow_unknown_urls
end
Capybara::Screenshot.autosave_on_failure = false
Capybara::Screenshot.prune_strategy = :keep_last_run
Capybara::Screenshot.webkit_options = { width: 1024, height: 768 }
Capybara.save_and_open_page_path = "../screenshots/"

class MinitestWorld
  extend Minitest::Assertions
  attr_accessor :assertions

  def initialize
    self.assertions = 0
  end
end
 
World do
  MinitestWorld.new
  Capybara.app = ApplicationController
end