Rails.application.routes.draw do

  resources :planets, only: [:show], param: :name
  resources :users
  resources :account_activations, only: [:edit]
  resources :password_resets, only: [:new, :create, :edit, :update]

  ### GET
  ## Static pages
  # home page
  root 'static_pages#home'
  # contact information
  get '/contact', to: 'static_pages#contact'
  # login from root page
  get '/', to: 'sessions#new'
  # login from login page
  get '/login', to: 'sessions#new'
  # signup
  get '/signup', to: 'users#new'
  # building
  get 'building/upgrade', to: 'buildings#upgrade'
  get 'building/percent', to: 'buildings#percent_bar'

  ### POST
  # signup
  post '/signup', to: 'users#create'
  # building
  post 'building/upgrade', to: 'buildings#upgrade'
  post 'building/cancel', to: 'buildings#cancel_upgrade_building'
  # unit
  post 'unit/train', to: 'units#train'
  # login from root page
  post '/', to: 'sessions#create'
  # login from login page
  post '/login', to: 'sessions#create'

  ### DELETE
  # disconnect
  delete '/logout', to: 'sessions#destroy'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
