Rails.application.routes.draw do
  get '/profile', to: 'users#show', as: 'profile'
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  #get 'home/index'
  get 'home/show'
  get 'home/create'
  get 'home/edit'
  get 'home/update'
  get 'home/destroy'
  # Defines the root path route ("/")
  # root "articles#index"
  root "home#index"
  #devise_for :users
end
