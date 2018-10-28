Rails.application.routes.draw do
  resources :posts
  root :to => "posts#index"
  get "/signup" => "users#new"
  post "/users" => "users#create"
end
