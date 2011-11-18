Localeze::Application.routes.draw do
  devise_for :users
  resources :base_records, :only => [:index, :show]
  root :to => 'devise/passwords#new', :via => :get
end