Rails.application.routes.draw do

  resources :planets
  resources :buildings
  resources :users
  resources :account_activations, only: [:edit]
  resources :password_resets, only: [:new, :create, :edit, :update]
  resources :account_actifs, only: [:edit]

  # URL home page
  root 'static_pages#home'

  get 'password_resets/new'
  get 'password_resets/edit'

  get 'sessions/new'

  get 'users/new'
  get 'planets/new'
  post 'buildings/new', to: 'planets#create_farm'

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

  post "planets/build" => "planets#construct"

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
