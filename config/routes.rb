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
  resources :users

end
# GET	/users	index	users_path	すべてのユーザーを表示するページ
# GET	/users/1	show	user_path(user)	特定のユーザーを表示するページ
# GET	/users/new	new	new_user_path	ユーザーを新規作成するページ (ユーザー登録)
# POST	/users	create	users_path	ユーザーを作成するアクション
# GET	/users/1/edit	edit	edit_user_path(user)	id=1のユーザーを編集するページ
# PATCH	/users/1	update	user_path(user)	ユーザーを更新するアクション
# DELETE	/users/1	destroy	user_path(user)	ユーザーを削除するアクション