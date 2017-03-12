module Helpers
  def send_text(message, number)
    if ApiVerification.exists?({name: "sinch"})
      api = ApiVerification.find_by({name: "sinch"})
      SinchSms.send(api.key, api.secret, message, number) if Sinatra::Application.production?
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
end