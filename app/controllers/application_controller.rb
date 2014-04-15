class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user

  private
  def current_user
    @current_user ||= session[:user_info] if session[:user_info]
  end
end
