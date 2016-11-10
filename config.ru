require "./app/controllers/application_controller"

# Setup Analytics
if Sinatra::Base.production?
  use Rack::GoogleAnalytics, :tracker => 'UA-87230200-1'
end

# Run Application
run ApplicationController