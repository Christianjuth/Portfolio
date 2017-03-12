module Helpers
  
  def record_uid(record)
    "#{record.class.table_name}_#{record.id}"
  end

  # This function takes a class instance and gets
  # it's validation errors parsing them as a string
  def error_for(object)
    if object.errors.first
      return "#{object.errors.first[0].to_s.gsub(/_/, "\s").capitalize} #{object.errors.first[1]}"
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
  
  def secure
    if !Sinatra::Application.production? || request.secure?
      yield
    else
      erb :security_warning, :layout => :centered_blank_layout
    end
  end

  def if_logged_in
    if @user
      secure do
        yield
      end
    else
      @lightning = true
      erb :"404", :layout => :centered_blank_layout
    end
  end
  
  def unless_logged_in
    if @user
      redirect "/"
    else
      yield
    end
  end
  
  def recaptcha
    if Sinatra::Application.test? || (ApiVerification.exists?({name: "recaptcha"}) && verify_recaptcha)
      yield
    elsif !ApiVerification.exists?({name: "recaptcha"})
      yield
    else
      return_request(false, request.referer, "Recaptcha failed")
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

  def send_text(message, number)
    if ApiVerification.exists?({name: "sinch"})
      api = ApiVerification.find_by({name: "sinch"})
      SinchSms.send(api.key, api.secret, message, number) if Sinatra::Application.production?
    end
  end
  
end

class Rational
  def to_ratio
    self.to_s.sub("/", ":")
  end
end