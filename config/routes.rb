Rails.application.routes.draw do

  root to: 'toppages#index'
  
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
  
  # #費用のCRUD
  resources :lists, only: [:new, :create, :edit, :update, :destroy]
  
   # #収入のCRUD
  resources :incomes, only: [:new, :create, :edit, :update, :destroy]
end
