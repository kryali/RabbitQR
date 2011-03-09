class ApplicationController < ActionController::Base
  before_filter :authenticate

  self.allow_forgery_protection = false

  def authenticate
    unless session[:user_id]
        redirect_to :login_form
    end
  end

  def isLoggedIn
    return session[:user_id]
  end

end
