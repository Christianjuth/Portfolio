class CoreController < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
  end
  
  include CoreHelpers
  
  # ----- Config ------
  configure do
    set :public_folder, "public"
    set :static_cache_control, [:public, {:max_age => 600}]
    set :views, "app/views"
    enable :sessions
    # Set the session secret
    set :session_secret, "secret"
  end
end