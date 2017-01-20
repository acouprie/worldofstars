Rails.application.routes.draw do
	
  get 'sessions/new'

  get 'users/new'
  	# URL home page
	root 'static_pages#home'
	# URL signup
	get '/signup', to: 'users#new'
	post '/signup', to: 'users#create'
	# URL contact information
  	get '/contact', to: 'static_pages#contact'
  	# URL sessions
  	get '/login', to: 'sessions#new'
	post '/login',to: 'sessions#create'
	delete '/logout', to: 'sessions#destroy'
	
  	resources :users

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
