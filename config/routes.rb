DealsApp::Application.routes.draw do

  resources :purchase_imports, only: [:index, :new] do
    post :create, :on => :collection
  end

  resources :import_reports, :only => [:index, :show]

  root 'purchase_imports#new'

end