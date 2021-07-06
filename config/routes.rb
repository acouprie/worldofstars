Rails.application.routes.draw do

  resources :planets, only: [:show], param: :name
  resources :users
  resources :account_activations, only: [:edit]
  resources :password_resets, only: [:new, :create, :edit, :update]

  # URL home page
  root 'static_pages#home'

  get 'password_resets/new'
  get 'password_resets/edit'

  get 'sessions/new'

  get 'users/new'
  get 'building/upgrade', to: 'buildings#upgrade'
  post 'building/upgrade', to: 'buildings#upgrade'
  post 'building/cancel', to: 'buildings#cancel_upgrade_building'
  get 'building/percent', to: 'buildings#percent_bar'

  post 'unit/train', to: 'units#train'

  # URL contact information
  get '/contact', to: 'static_pages#contact'

  # URL signup
  get '/signup', to: 'users#new'
  post '/signup', to: 'users#create'

  # URL login
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'

  # Login from root page
  get '/', to: 'sessions#new'
  post '/', to: 'sessions#create'

  # URL logout
  delete '/logout', to: 'sessions#destroy'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
