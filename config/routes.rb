Rails.application.routes.draw do
  devise_for :users
  root "users#top"
  resources :users
  resources :books
  get "home/about" => "users#about"
end
