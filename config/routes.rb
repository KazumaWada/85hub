Rails.application.routes.draw do
  get '/profile', to: 'users#show', as: 'profile'
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
  #あとで、user#showに、entryを持ってきたいから、変える。いや、ここで作って、user#showにレンダリングすればいい。
  resources :entries, only: [:index, :new, :create, :show] do
    member do
      post :button_click_action
    end
    end
    
    resources :users, only: [:show] do
      member do
        post :button_click_action
      end
  end
end
