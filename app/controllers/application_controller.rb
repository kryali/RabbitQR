class ApplicationController < ActionController::Base
  before_filter :authenticate

  self.allow_forgery_protection = false

  # Twilio details
  @account_token = "e1300015f2ec746e322877054388d1b1"
  @account_id= "AC1b8f7b8d29f93745eff06c9c2aa781b4"
  @caller_id = "4155992671"
  @sms_rest = "http://demo.twilio.com/welcome/sms"
  @twilio_api_version = '2010-04-01'
  

  def send_text(phone, text)

    text = URI.escape(text, Regexp.new("[^#{URI::PATTERN::UNRESERVED}]"))
    account = Twilio::RestAccount.new(@account_id, @account_token)
    payload = {
        'From' => @caller_id,
        'To' => phone,
        'Body' => text,
        'Url' => @sms_text
    }
    resp = account.request("/#{@twilio_api_version}/Accounts/#{@account_id}/SMS/Messages", 'POST', payload)
    logger.debug "Twilio Response: #{resp}"
  end

  def authenticate
    unless session[:user_id]
        redirect_to :login_form
    end
  end

  def isLoggedIn
    return session[:user_id]
  end

end
