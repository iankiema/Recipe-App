Rails.application.routes.draw do
  devise_for :users
  resources :login

  resources :login, only: [:index, :create, :destroy]

  root 'login#index'

end
