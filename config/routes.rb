DealsApp::Application.routes.draw do
  resources :purchase_imports, only: [:index, :new] do
    post :create, :on => :collection
  end

  resources :import_reports, :only => [:index, :show]

  root 'welcome#index'

  resources :sessions, only: [:create, :destroy]
  post '/auth/:provider/callback'  => 'sessions#create'
  get 'log_out' => "sessions#destroy", :as => 'log_out'
  get '/auth/failure'  => 'sessions#failure'
end