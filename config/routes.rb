DealsApp::Application.routes.draw do

  resources :purchase_imports, only: [:new] do
    post :create, :on => :collection
  end

  resources :import_reports, :only => [:show]

  root 'purchase_imports#new'

end