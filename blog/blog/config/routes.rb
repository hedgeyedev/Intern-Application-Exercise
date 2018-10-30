Rails.application.routes.draw do

  # resources :likes
  resources :posts do
    resources :comments, only: [:create, :destroy]
  end
  resources :posts do
    resources :likes, only: [:create]
  end
  root :to => "posts#index"
  get "/signup" => "users#new"
  post "/users" => "users#create"
  get "/login" => "sessions#new"
  post "/login" => "sessions#create"
  get "/logout" => "sessions#destroy"
end
