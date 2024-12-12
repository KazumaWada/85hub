Rails.application.routes.draw do
  
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  root "home#index"
  get '/about',to: 'home#about', as: 'about'
  get '/signup', to: 'users#new', as: 'signup'
  post '/signup', to: 'users#create'

  get '/login', to: 'sessions#new', as: 'login'
  post '/login', to: 'sessions#create', as: 'login_with_cookie'
  delete '/logout', to: 'sessions#destroy', as: 'logout'
  get '/app', to: 'home#app', as: 'app'
  resources :sessions, only: [:create]#paramsで見つけられるように。
  
  get '/question', to: 'home#question', as: 'question'
  get '/blog', to: "home#blog", as: 'blog'
  resources :microposts, only: [:index]#slugで先に影響されないように。/micropostsは危ないから。
  
  #frieendly_id
  get '/:slug', to: 'users#show', as: :user #user_pathを記述できるようになる。
  #.com/user.name/posts/1
  scope '/:slug' do
    get 'zen', to: 'microposts#zen_new', as: 'zen' #zen_path(slug: 'example-slug')
    post 'zen/microposts', to: 'microposts#zen_create'
    #post送信用のurl
    #post '/zen/microposts', to: 'microposts#create', as: :zen_microposts
    resources :microposts, only: [:create, :destroy, :new] #, path: 'posts'
    
  end



  get 'home/show'
  get 'home/create'
  get 'home/edit'
  get 'home/update'
  get 'home/destroy'
  
  # Defines the root path route ("/")
  # root "articles#index"
  resources :users, only: [:index, :new, :create, :destroy]
  #get '/profile', to: 'users#show', as: :profile

# # profile配下にpostsをネスト profile/posts/1
#resources :users, only: [:show] do
 #resources :microposts, only: [:create, :destroy, :index] #path: 'posts' (/pathとなる。)
#end
  #resources :microposts, only: [:create, :destroy, :index]#/posts, /posts/1

  
  #delete 'logout'  => 'sessions#destroy'
  #postはuser-viewに存在するからcreateとdestroyのみでok


end
# GET	/users	index	users_path	すべてのユーザーを表示するページ
# GET	/users/1	show	user_path(user)	特定のユーザーを表示するページ
# GET	/users/new	new	new_user_path	ユーザーを新規作成するページ (ユーザー登録)
# POST	/users	create	users_path	ユーザーを作成するアクション
# GET	/users/1/edit	edit	edit_user_path(user)	id=1のユーザーを編集するページ
# PATCH	/users/1	update	user_path(user)	ユーザーを更新するアクション
# DELETE	/users/1	destroy	user_path(user)	ユーザーを削除するアクション

#これについてあとで調べる
# method: :delete の仕組み
# Rails の link_to ヘルパーで method: :delete を使うと、JavaScript (@rails/ujs) が裏で動作して、DELETE メソッドのリクエストをサーバーに送信します。

# もしこの JavaScript が読み込まれていない、または有効になっていない場合、ブラウザは GET リクエストを送信します。その結果、ルーティングエラーが発生します。

