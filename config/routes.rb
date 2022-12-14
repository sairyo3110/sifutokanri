Rails.application.routes.draw do
  namespace :admin do
    resources :posts
  end

  post "/admin/posts/:date/create/:id" => "admin/posts#create" 
  get "/admin/posts/:id/edit/:date" => "admin/posts#edit"
  post "/admin/posts/:id/update" => "admin/posts#update"
  get "/admin/posts/:id/destroy" => "admin/posts#destroy"

  get 'blogs/index'
  get 'cal/index'
  get "login" => "users#login_form"
  post "login" => "users#login"
  get "logout" => "users#logout"

  post "users/:id/update" => "users#update"
  get "users/:id/edit" => "users#edit"
  post "users/create" => "users#create"
  get "signup" => "users#new"
  get "users/index" => "users#index"
  get "users/:id" => "users#show"

  get "posts/:date" => "posts#new"
  get "posts/:id" => "posts#show"
  post "posts/:date/create" => "posts#create" 
  get "posts/:id/edit" => "posts#edit"
  post "posts/:id/update" => "posts#update"
  get "posts/:id/destroy" => "posts#destroy"
  
  get "/" => "users#login_form"
  get "about" => "home#about"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end