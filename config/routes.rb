Rails.application.routes.draw do
	
  get 'password_resets/new'

  get 'password_resets/edit'

  get 'sessions/new'

  get 'users/new'
  	# URL home page
	root 'static_pages#home'
	
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

  	resources :users
  	resources :account_activations, only: [:edit]
  	resources :password_resets, only: [:new, :create, :edit, :update]

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
