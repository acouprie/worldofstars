Rails.application.routes.draw do
	
  get 'users/new'

	root 'static_pages#home'

	get '/register', to: 'users#new'
  	get '/contact', to: 'static_pages#contact'
  	resources :users

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
