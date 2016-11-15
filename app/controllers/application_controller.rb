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
    if @user
      page = Page.new()
      page.save()
      case request_type?
      when :ajax
        body({
          success: true, 
          message: "success",
          redirect: "/page/edit/#{page.id}"
          }.to_json)
      else 
        redirect "/page/edit/#{page.id}"
      end
    end
  end
  
  get "/page/edit/:id" do
    if @user
      @page = Page.find(params[:id])
      erb :"page/edit"
    else
      erb :"404"
    end
  end
  
  post "/page/update/:id" do
    if @user
      @page = Page.find(params[:id])
      @page.title = params[:title]
      @page.comments = params[:comments]
      @page.content = params[:content]
      if @page.valid?
        @page.save
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
            message: "#{@page.errors.first[0].capitalize} #{@page.errors.first[1]}"
            }.to_json)
        else 
          redirect request.referer
        end
      end
    else
      erb :"404"
    end
  end
  
  post "/page/delete/:id" do
    if @user
      @page = Page.find(params[:id])
      @page.delete
      case request_type?
      when :ajax
        body({
          success: true, 
          message: "success",
          redirect: "/pages"
          }.to_json)
      else 
        redirect "/pages"
      end
    else
      erb :"404"
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
    if @user
      @edit_entry = PortfolioEntry.find(params[:id])
      erb :"portfolio/edit"
    else
      erb :"404"
    end
  end
  
  post "/portfolio/update/:id" do
    if @user
      @entry = PortfolioEntry.find(params[:id])
      @entry.title = params[:title]
      @entry.color = params[:color]
      @entry.date = Date.parse(params[:date])
      @entry.blurb = params[:blurb]
      @entry.font = params[:font]
      @entry.github = params[:github]
      @entry.website = params[:website]
      @entry.description = params[:description]
      if @entry.valid?
        @entry.save
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
            message: "#{@entry.errors.first[0].capitalize} #{@entry.errors.first[1]}"
            }.to_json)
        else 
          redirect request.referer
        end
      end
    end
  end
  
  post "/portfolio/new_entry" do
    if @user
      entry = PortfolioEntry.new()
      entry.save()
      case request_type?
      when :ajax
        body({
          success: true, 
          message: "success",
          redirect: "/portfolio/edit/#{entry.id}"
          }.to_json)
      else 
        redirect "/portfolio/edit/#{entry.id}"
      end
    end
  end
  
  post "/portfolio/delete/:id" do
    if @user
      @entry = PortfolioEntry.find(params[:id])
      @entry.delete
      case request_type?
      when :ajax
        body({
          success: true, 
          message: "success",
          redirect: "/portfolio"
          }.to_json)
      else 
        redirect "/portfolio"
      end
    else
      erb :"404"
    end
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
    @comments = false
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
