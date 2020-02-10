Rails.application.routes.draw do
  root to: 'toppages#index'
  
  #アイテムのCRUD
  get 'lists/new'
  post 'lists/create'
  get 'lists/edit'
  post 'lists/update'
  delete 'lists/destroy'
  
  #ユーザのログイン・ログアウト
  get 'sessions/new'
  post 'sessions/create'
  delete 'sessions/destroy'
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  
  #ユーザの作成
  get 'signup', to: 'users#new'
  resources :users, only: [:show, :new, :create]
  
  resources :lists, only: [:new, :create, :edit, :update, :destroy]
end
