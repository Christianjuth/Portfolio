# Setup environment
require "./config/environment"

# Require models
require "./app/models/user"
require "./app/models/api_verification"

# Set routs
class ApplicationController < Sinatra::Base
  # This routs the home page to the template
  get "/" do
    erb :index
  end

  get "/portfolio" do
    erb :portfolio
  end

  get "/music" do
    erb :music
  end

  get "/settings" do
    @api_verification = ApiVerification.all
    erb :settings
  end

  # This routs the login page to the template
  get "/login" do
    erb :login
  end

  post "/login" do
    # check if user exsists
    if User.find_by({username: params[:username]})
      @user = User.find_by({username: params[:username]})
    end
    # check password and set session
    if @user && @user.password(params[:password])
      session[:user_id] = @user.id
      case request_type?
      when :ajax
        body({
          success: true, 
          message: "success",
          redirect: "/"
          }.to_json)
      else 
        redirect "/"
      end
    else
      case request_type?
      when :ajax
        status 500
        body({
          success: false, 
          message: "Incorrect username or password"
          }.to_json)
      else 
        redirect "/login"
      end
    end
  end

  post "/change_password" do
    # check password and set session
    if @user
      # try and update password
      @user.password = params[:new_password]
      
      if params[:new_password] == params[:confirm_password] && @user.valid?
        # save password to database
        @user.save
        # notify page
        case request_type?
        when :ajax
          body({
            success: true, 
            message: "success",
            redirect: request.referer
            }.to_json)
        else 
          redirect request.referer
        end
      else
        case request_type?
        when :ajax
          status 500
          body({
            success: false, 
            message: "Passwords do not match"
            }.to_json)
        else 
          redirect request.referer
        end
      end
    end
  end

  post "/logout" do
    session.destroy
    case request_type?
    when :ajax
      body({
        success: true, 
        message: "success",
        redirect: "/"
        }.to_json)
    else 
      redirect "/"
    end
  end

  error Sinatra::NotFound do
    erb :"404"
  end

  # ----- Config ------
  configure do
    set :public_folder, "public"
    set :views, "app/views"
    enable :sessions
    # Set the session secret
    set :session_secret, "secret"
  end

  # This function will redirect the user
  # to the login screen (if enabled) when the 
  # session[:user_id] is nil else it will 
  # pass @user as the current user into the
  # requested view
  before do
    # Force the user to login before using the app
    force_login_page = false
    exceptions = ["/login"]
    # Check the session and database for current user
    if (!session[:user_id] || !User.exists?(session[:user_id])) && !exceptions.include?(request.path)
      session.destroy
      redirect "/login" if force_login_page
    elsif !["/login"].include?(request.path)
      @user = User.find(session[:user_id])
    end
  end


  # ----- Helpers -----

  # This function takes a class instance and gets
  # it's validation errors parsing them as a string
  def error_messages_for(object)
    all_errors = ""
    for error in object.errors.messages do
      key = error.first.to_s.capitalize
      what_is_wrong = error.second.join(' and ')
      all_errors += "#{key} #{what_is_wrong}.\n"
    end
    all_errors
  end

  # This functin allows you to check if the
  # request is form a form subbmission or ajax
  def request_type?
    return :ajax    if request.xhr?
    return :normal
  end
end
