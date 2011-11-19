Localeze::Application.routes.draw do
  devise_for :users
  resources :base_records, :only => [:index, :show]
  root :to => 'base_records#index', :via => :get
end