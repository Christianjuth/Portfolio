Before("~@fails") do
  @fails = false
end

Before("@fails") do
  @fails = true
end

Before do
  Capybara.current_driver = :webkit
  def assert_cucumber(params)
    begin 
      assersion = params[:assersion].call
    rescue
      assersion = false
    end  
    pass = [true, false].include?(assersion) ? assersion != @fails : true
    error = @fails ? "succeeded #{params[:error]}" : params[:error]
    # check assersion
    if pass == false
      screenshot_and_save_page
    end
    assert(pass, error)
  end
end

After do |scenario|
  DatabaseCleaner.clean
end