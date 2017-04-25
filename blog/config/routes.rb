Rails.application.routes.draw do
  resources :posts do 
  	resources :comments
  end
  get '/posts/delete/:id', to: 'posts#delete', as: 'delete_post'
  root to: "posts#index"
end
