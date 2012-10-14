Researcher::Application.routes.draw do
  resources :terms

  resources :posts
  resources :users
  resources :sessions

  get "sessions/new"
  get "users/new"
  get "logout" => "sessions#destroy", :as => "logout"
  get "login" => "sessions#new", :as => "login"
  get "signup" => "users#new", :as => "signup"
  get "admin" => "users#index", :as => "admin"


  root :to => 'posts#index'

end
