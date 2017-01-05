Rails.application.routes.draw do
  resources :messages
  resources :comments
  resources :passengers
  resources :neighborhoods
  resources :cities
  resources :rides
  resources :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
