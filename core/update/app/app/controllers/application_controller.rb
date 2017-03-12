# Setup environment
require "./config/environment"
configure = JSON.parse(File.read("./configure.json"))

# Require helpers
require "./app/helpers/helpers"

# Require models
require "./app/models/user"
require "./app/models/password_reset"
require "./app/models/api_verification"
require "./app/models/standard"

# Set routs
class ApplicationController < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
  end
  
  include Helpers
  include Recaptcha::ClientHelper
  include Recaptcha::Verify
  
  # ----- Configure -----
  recaptcha_site_key = ""
  Recaptcha.configure do |config|
    if ApiVerification.exists?({name: "recaptcha"})
      recaptcha = ApiVerification.find_by({name: "recaptcha"})
      config.site_key = recaptcha.key
      config.secret_key = recaptcha.secret
      recaptcha_site_key = config.site_key
    end
  end
  
  if ApiVerification.exists?({name: "algolia"})
    algolia = ApiVerification.find_by({name: "algolia"})
    Algolia.init({
      application_id: algolia.key,
      api_key:        algolia.secret
    })
  end

  if ApiVerification.exists?({name: "cloudinary"})
    Cloudinary.config do |config|
      config.cloud_name = "christianjuth-juth"
      config.api_key = ApiVerification.find_by({name: "cloudinary"}).key
      config.api_secret = ApiVerification.find_by({name: "cloudinary"}).secret
      config.cdn_subdomain = true
    end
  end
  
  # -------- Setup Routs ---------
  # This routs the home page to the template
  get "/" do
    if params[:search]
      @standards = Standard.where("lower(title) like ?", "%#{params[:search].downcase}%")
    else
      @standards = []
    end
    @lightning = true
    erb :index, :layout => :centered_blank_layout
  end
  

  get "/settings" do
    if_logged_in do
      @api_verification = ApiVerification.all
      @lightning = false
      erb :settings
    end
  end
  
  get "/standards" do
    if_logged_in do
      @standards = Standard.order(:title)
      erb :"standards/standards"
    end
  end
  
  get "/standards/edit/:id" do
    if_logged_in do
      @standard = Standard.find(params[:id])
      erb :"standards/edit"
    end
  end
  
  post "/standards/update/:id" do
    if_logged_in do
      standard = Standard.find(params[:id])
      standard.title = params[:title]
      standard.height = params[:height]
      standard.width = params[:width]
      standard.description = params[:description]
      standard.source = params[:source]
      return_request(standard.valid?, request.referer, error_for(standard)) do
        standard.save
        if ApiVerification.exists?({name: "algolia"})
          index = Algolia::Index.new("standards") 
          batch = [standard.as_json]
          batch.collect do |batch_item|
            batch_item["objectID"] = batch_item["id"]
          end
          index.save_objects(batch)
        end
      end
    end
  end
  
  post "/standards/sync_algolia" do
    if ApiVerification.exists?({name: "algolia"})
      index = Algolia::Index.new("standards")
      batch = Standard.order(:title).as_json
      batch.collect do |standard|
        standard["objectID"] = standard["id"]
      end
      index.save_objects(batch)
    end
  end
  
  
  post "/standards/new" do
    if_logged_in do
      standard = Standard.new
      standard.save
      return_request(true, "/standards/edit/#{standard.id}")
    end
  end
  
  post "/standards/delete/:id" do
    return_request(true, "/standards", nil) do
      Standard.find(params[:id]).destroy
      if ApiVerification.exists?({name: "algolia"})
        index = Algolia::Index.new("standards")
        index.delete_object(params[:id])
      end
    end
  end

  get "/login" do
    secure do
      unless_logged_in do
        erb :login, :layout => :centered_blank_layout
      end
    end
  end
  
  get "/forgot_password" do
    secure do
      unless_logged_in do
        erb :forgot_password, :layout => :centered_blank_layout
      end
    end
  end
  
  post "/request_password_reset" do
    recaptcha do
      if !User.find_by({username: params[:username]})
        return_request(false, request.referer, "User not found")
      elsif User.find_by({username: params[:username]}).phone_number_verified == false
        return_request(false, request.referer, "User's phone number is not verified")
      else
        user = User.find_by({username: params[:username]})
        token = SecureRandom.urlsafe_base64(30, true)
        if user.password_resets.any?
          user.password_resets.destroy_all
        end
        password_reset = PasswordReset.new({
          user_id: user.id,
          token: token
        })
        return_request(password_reset.valid?, "/login?requested_password_reset=true", error_for(password_reset)) do
          send_text("Reset password #{@host}/reset_password?id=#{user.id}&token=#{token}", user.phone_number)
          password_reset.save
        end
      end
    end
  end
  
  get "/reset_password" do
    secure do
      unless_logged_in do
        erb :reset_password, :layout => :centered_blank_layout
      end
    end
  end
  
  post "/reset_password" do
    recaptcha do
      if params[:id].nil? || !User.exists?({id: params[:id]})
        return_request(false, request.referer, "user not found")
      elsif params[:new_password] != params[:confirm_password]
        return_request(false, request.referer, "Passwords do not match")
      else
        user = User.find(params[:id])
        token = user.password_resets.find_by({token: params[:token]})
        user.password = params[:new_password]
        error = user.valid? ? "Password resent token is invalid or has already ben used." : error_for(user)
        return_request(user.valid? && token, "/login", error) do
          user.save
          token.destroy
          # set session
          session[:user_id] = user.id
        end
      end
    end
  end

  post "/login" do
    recaptcha do
      # check if user exists
      if User.find_by({username: params[:username]})
        user = User.find_by({username: params[:username]})
      end
      # check password and set session
      return_request(user && user.password(params[:password]), "/", "Incorrect username or password") do
        session[:user_id] = user.id
      end
    end
  end
  
  post "/user/update/:id" do
    if_logged_in do
      user = User.find(params[:id])
      user.username = params[:username]
      phone = params[:phone_number].gsub(/\s-\(\s{3}\)-\s{3}-\s{4}/, "")
      user.phone = phone
      return_request(user.valid?, request.referer, error_for(user)) do
        user.save
      end
    end
  end
  
  post "/phone/resend_verification/:id" do
    if_logged_in do
      user = User.find(params[:id])
      unless user.phone_number_verified
        code = SecureRandom.urlsafe_base64(30, true)
        user.phone_verification_code = code
        send_text("Verify your phone number #{@host}/phone/verify?id=#{user.id}&code=#{code}", user.phone_number)
      end
      return_request(user.valid?, request.referer, error_for(user)) do
        user.save
      end
    end
  end
  
  get "/phone/verify" do
    verify_user = User.find(params[:id])
    if verify_user.phone_verification_code == params[:code]
      verify_user.phone_number_verified = true
      verify_user.phone_verification_code = ""
      verify_user.save
      if @user
        return_request(true, "/settings")
      else
        return_request(true, "/")
      end
    end
  end

  post "/user/change_password" do
    # check password and set session
    if_logged_in do
      if params[:new_password] != params[:confirm_password]
        return_request(false, request.referer, "Passwords do not match")
      else
        # try and update password
        @user.password = params[:new_password]
        return_request(@user.valid?, request.referer, error_for(@user)) do
          @user.save
        end
      end
    end
  end

  post "/logout" do
    session.destroy
    return_request
  end
  
  post "/api_verification/new_api_verification" do
    if_logged_in do
      api = ApiVerification.new
      return_request(api.valid?, request.referer, error_for(api)) do
        api.save
      end
    end
  end
  
  post "/api_verification/update/:id" do
    if_logged_in do
      api = ApiVerification.find(params[:id])
      api.name = params[:name]
      api.key = params[:key]
      api.secret = params[:secret]
      return_request(api.valid?, request.referer, error_for(api)) do
        api.save
      end
    end
  end
  
  post "/api_verification/delete/:id" do
    return_request(true, request.referer, nil) do
      ApiVerification.find(params[:id]).destroy
    end
  end

  error Sinatra::NotFound do
    @lightning = true
    erb :"404", :layout => :centered_blank_layout
  end

  # ----- Config ------
  configure do
    set :public_folder, "public"
    set :static_cache_control, [:public, {:max_age => 600}]
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
    if recaptcha_site_key
      @recaptcha_key = recaptcha_site_key
    else
      @recaptcha_key = ""
    end
    @production = Sinatra::Application.production?
    # Force the user to login before using the app
    force_login_page = false
    exceptions = ["/login", "/forgot_password", "/reset_password"]
    file_exceptions = ["gz"]
    # Check the session and database for current user
    # !session[:user_id] to prevent session[:user_id] undefined
    if (!session[:user_id] || !User.exists?(session[:user_id]))
      session.destroy
      if !exceptions.include?(request.path) && !file_exceptions.include?(request.path.split(".")[-1])
        redirect "/login" if force_login_page
      end
    else
      @user = User.find(session[:user_id])
    end
    @comments = false
    @host = request.base_url
    @lightning = false
  end
end