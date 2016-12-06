# Setup environment
require "./config/environment"

# Require helpers
require "./app/helpers/helpers"

# Require models
require "./app/models/user"
require "./app/models/password_reset"
require "./app/models/api_verification"
require "./app/models/message"
require "./app/models/page"
require "./app/models/portfolio_entry"

# Set routs
class ApplicationController < Sinatra::Base
  include Helpers
  
  # This routs the home page to the template
  get "/" do
    if Page.exists?(title: "home")
      @page = Page.find_by(title: "home")
      @comments = @page.comments
      erb :index
    else
      @page = false
      erb :index
    end
  end
  
  get "/messages" do
    if_logged_in do
      @messages = Message.order("created_at DESC").all
      erb :"message/messages"
    end
  end
  
  get "/message/:id" do
    if_logged_in do
      @message = Message.find(params[:id])
      @message.unread = false
      @message.save
      erb :"message/message"
    end
  end
  
  post "/message/submit" do
    message = Message.new({
      name: params[:name],
      email: params[:email],
      fun_fact: params[:fun_fact],
      message: params[:message]
    })
    return_request(message.valid?, "/?message_sent=true#Contact", error_for(message)) do
      message.save
      if User.first.phone_number_verified
        send_text("New form submission ChristianJuth.com from #{params[:email]}", User.first.phone_number)
      end
    end
  end
  
  post "/message/delete/:id" do
    if_logged_in do
      @message = Message.find(params[:id])
      @message.destroy
      return_request(true, "/messages")
    end
  end
  
  get "/pages" do
    if_logged_in do
      erb :"page/pages"
    end
  end
  
  get "/page/:title" do
    if params[:title].downcase == "home"
      redirect "/"
    end
    if Page.exists?({title: params[:title].downcase})
      @page = Page.find_by(title: params[:title].downcase)
      @comments = @page.comments
      erb :"page/page"
    else
      erb :"404"
    end
  end
  
  post "/page/new_page" do
    if_logged_in do
      page = Page.new
      page.save
      return_request(true, "/page/edit/#{page.id}")
    end
  end
  
  get "/page/edit/:id" do
    if_logged_in do
      @page = Page.find(params[:id])
      erb :"page/edit"
    end
  end
  
  post "/page/update/:id" do
    if_logged_in do
      page = Page.find(params[:id])
      page.title = params[:title]
      page.comments = params[:comments]
      page.content = params[:content]
      return_request(page.valid?, request.referer, error_for(page)) do
        page.save
      end
    end
  end
  
  post "/page/delete/:id" do
    if_logged_in do
      @page = Page.find(params[:id])
      @page.delete
      return_request(true, "/pages")
    end
  end

  get "/portfolio" do
    @portfolio_entries = PortfolioEntry.order("date DESC")
    erb :"portfolio/portfolio"
  end
  
  get "/portfolio/:id" do
    @comments = true
    if PortfolioEntry.exists?({id: params[:id]})
      @entry = PortfolioEntry.find(params[:id])
      erb :"portfolio/entry"
    else
      erb :"404"
    end
  end
  
  get "/portfolio/edit/:id" do
    if_logged_in do
      @edit_entry = PortfolioEntry.find(params[:id])
      erb :"portfolio/edit"
    end
  end
  
  post "/portfolio/update/:id" do
    if_logged_in do
      entry = PortfolioEntry.find(params[:id])
      entry.title = params[:title]
      entry.color = params[:color]
      entry.date = params[:date]
      entry.blurb = params[:blurb]
      entry.font = params[:font]
      entry.github = params[:github]
      entry.website = params[:website]
      entry.description = params[:description]
      return_request(entry.valid?, request.referer, error_for(entry)) do
        entry.save
      end
    end
  end
  
  post "/portfolio/new_entry" do
    if_logged_in do
      entry = PortfolioEntry.new
      entry.save
      return_request(true, "/portfolio/edit/#{entry.id}")
    end
  end
  
  post "/portfolio/delete/:id" do
    if_logged_in do
      @entry = PortfolioEntry.find(params[:id])
      @entry.delete
      return_request(true, "/portfolio")
    end
  end

  get "/settings" do
    if_logged_in do
      @api_verification = ApiVerification.all
      erb :settings
    end
  end

  get "/login" do
    erb :login, :layout => :centered_blank_layout
  end
  
  get "/forgot_password" do
    erb :forgot_password, :layout => :centered_blank_layout
  end
  
  post "/request_password_reset" do
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
        send_text("Reset password http://www.christianjuth.com/reset_password?id=#{user.id}&token=#{token}", user.phone_number)
        password_reset.save
      end
    end
  end
  
  
  get "/reset_password" do
    erb :reset_password, :layout => :centered_blank_layout
  end
  
  post "/reset_password" do
    if !User.find(params[:id])
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
      end
    end
  end

  post "/login" do
    # check if user exsists
    if User.find_by({username: params[:username]})
      user = User.find_by({username: params[:username]})
    end
    # check password and set session
    return_request(user && user.password(params[:password]), "/", "Incorrect username or password") do
      session[:user_id] = user.id
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
        send_text("Verify your phone number http://www.christianjuth.com/phone/verify?id=#{user.id}&code=#{code}", user.phone_number)
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
      # try and update password
      @user.password = params[:new_password]
      return_request(
        params[:new_password] == params[:confirm_password] && @user.valid?, request.referer, "Passwords do not match") do
        @user.save
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
    erb :"404"
  end
  
  # --------------- Set GZIP ----------------
  get (/css\/.*\.gz\Z/) do
    content_type 'css'
    gzip_file = "public#{request.path_info.gsub(/\.gz/, '.css.gz')}"
    css_file = "public#{request.path_info.gsub(/\.gz/, '.css')}"
    if File.file?(gzip_file) && Sinatra::Application.production?
      headers['Content-Encoding'] = 'gzip'
      File.read(gzip_file)
    else
      File.read(css_file)
    end
  end
  
  get (/js\/.*\.gz\Z/) do
    content_type 'js'
    gzip_file = "public#{request.path_info.gsub(/\.gz/, '.js.gz')}"
    js_file = "public#{request.path_info.gsub(/\.gz/, '.js')}"
    if File.file?(gzip_file) && Sinatra::Application.production?
      headers['Content-Encoding'] = 'gzip'
      File.read(gzip_file)
    else
      File.read(js_file)
    end
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
    # Force the user to login before using the app
    force_login_page = false
    exceptions = ["/login"]
    # Check the session and database for current user
    # !session[:user_id] to prevent session[:user_id] undefined
    if (!session[:user_id] || !User.exists?(session[:user_id])) && !exceptions.include?(request.path)
      session.destroy
      redirect "/login" if force_login_page
    elsif !["/login"].include?(request.path)
      @user = User.find(session[:user_id])
    end
    @comments = false
  end
end
