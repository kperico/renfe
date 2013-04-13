class ApplicationController < ActionController::Base
  protect_from_forgery

  def logged_in?
    session[:user].present?
  end

  def logged_in!(user)
    session[:user] = user
  end

  def authorize!
    redirect_to new_alert_url unless logged_in?
  end
end
