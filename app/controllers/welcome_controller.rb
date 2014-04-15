class WelcomeController < ApplicationController
  def index
    redirect_to new_purchase_import_url if current_user
  end
end