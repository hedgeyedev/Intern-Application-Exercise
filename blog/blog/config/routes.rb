Rails.application.routes.draw do
  resources :posts
  root :to => "posts#index"
  get "/signup" => "users#new"
  post "/users" => "users#create"
  get "/login" => "sessions#new"
  post "/login" => "sessions#create"
  get "/logout" => "sessions#destroy"
  post "/posts/:id/update_like" => "posts#update_like"
  post "/posts/:id/update_dislike" => "posts#update_dislike"
end
