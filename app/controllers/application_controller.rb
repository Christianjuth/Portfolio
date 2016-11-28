# Setup environment
require "./config/environment"

# Require models
require "./app/models/user"
require "./app/models/page"
require "./app/models/api_verification"
require "./app/models/portfolio_entries"

# Set routs
class ApplicationController < Sinatra::Base
  
  # This routs the home page to the template
  get "/" do
    if Page.exists?(title: "home")
      @page = Page.find_by(title: "home")
      @comments = @page.comments
      @contact = true
      erb :index
    else
      erb :"404"
    end
  end
  
  get "/pages" do
    erb :"page/pages"
  end
  
  get "/page/:title" do
    if params[:title].downcase == "home"
      redirect "/"
    end
    @page = Page.find_by(title: params[:title].downcase)
    @comments = @page.comments
    erb :"page/page"
  end
  
  post "/page/new_page" do
    if_logged_in do
      page = Page.new()
      page.save()
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
    @portfolio_entries = PortfolioEntry.order(:date).reverse
    erb :"portfolio/portfolio"
  end
  
  get "/portfolio/:id" do
    @comments = true
    @entry = PortfolioEntry.find(params[:id])
    erb :"portfolio/entry"
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
      entry = PortfolioEntry.new()
      entry.save()
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
    return_request(@user && @user.password(params[:password]), "/", "Incorrect username or password") do
      session[:user_id] = @user.id
    end
  end

  post "/change_password" do
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
    return_request()
  end
  
  post "/api_verification/new_api_verification" do
    if_logged_in do
      api = ApiVerification.new()
      return_request(api.valid?, request.referer, error_for(api)) do
        api.save()
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
  get  /css\/.*\.gz/ do
    content_type 'css'
    gzip_file = "public#{request.path_info.gsub(/\.gz/, '.css.gz')}"
    css_file = "public#{request.path_info.gsub(/\.gz/, '.css')}"
    if File.file?(gzip_file)
      headers['Content-Encoding'] = 'gzip'
      File.read(gzip_file)
    else
      File.read(css_file)
    end
  end
  
  get  /js\/.*\.gz/ do
    content_type 'js'
    gzip_file = "public#{request.path_info.gsub(/\.gz/, '.js.gz')}"
    js_file = "public#{request.path_info.gsub(/\.gz/, '.js')}"
    if File.file?(gzip_file)
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
    if (!session[:user_id] || !User.exists?(session[:user_id])) && !exceptions.include?(request.path)
      session.destroy
      redirect "/login" if force_login_page
    elsif !["/login"].include?(request.path)
      @user = User.find(session[:user_id])
    end
    @comments = false
    @contact = false
  end


  # ----- Helpers -----

  # This function takes a class instance and gets
  # it's validation errors parsing them as a string
  def error_for(object)
    if object.errors.first
      return "#{object.errors.first[0].capitalize} #{object.errors.first[1]}"
    else
      return ""
    end
  end

  # This functin allows you to check if the
  # request is form a form subbmission or ajax
  def request_type?
    return :ajax    if request.xhr?
    return :normal
  end
  
  def if_logged_in
    if @user
      yield
    else
      erb :"404"
    end
  end
  
  def return_request(condition = true, redirect_url = "/", error = "")
    if condition
      if block_given?
        yield
      end
      case request_type?
      when :ajax
        body({
          success: true, 
          message: "success",
          redirect: redirect_url
          }.to_json)
      else 
        redirect redirect_url
      end
    else
      case request_type?
      when :ajax
        status 500
        body({
          success: false, 
          message: error
          }.to_json)
      else 
        redirect request.referer
      end
    end
  end
end
