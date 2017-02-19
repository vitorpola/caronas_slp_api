Rails.application.routes.draw do
  resources :messages
  resources :comments
  resources :passengers
  resources :neighborhoods
  resources :cities
  resources :rides
  resources :users do
    collection do
      post :check_email
      post :login
    end
  end

  match 'auth/:provider/callback',    to: 'authentications#create', via: [:get, :post]
  match 'auth/failure',               to: 'authentications#failure', via: [:get, :post]

end
