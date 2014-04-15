class SessionsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    auth = request.env["omniauth.auth"]
    session[:user_info] = auth["info"]
    redirect_to new_purchase_import_url, :notice => "Signed in!"
  end

  def destroy
    session[:user_info] = nil
    redirect_to root_url, :notice => "Signed out!"
  end

  def failure
    redirect_to root_url, alert: "Authentication failed, please try again."
  end
end