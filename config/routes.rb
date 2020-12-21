Rails.application.routes.draw do
  root to: 'toppages#index'
  
  
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  post "posts/new" => "posts#new"
  get 'signup', to: 'users#new'
  
  
  resources :users, only: [:index, :show, :new, :create, :edit, :update, :destroy]do
    member do
      get :followings
      get :followers
      get :likes
    end
  end
  
  resources :posts, only: [:new, :create, :show, :edit, :update, :destroy] do
    resources :comments, only: [:create, :destroy]
  end
  resources :relationships, only: [:create, :destroy]
  resources :favorites, only: [:create, :destroy]
  
end

