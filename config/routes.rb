Rails.application.routes.draw do
  devise_for :users
  devise_scope :user do  
    get '/users/sign_out' => 'devise/sessions#destroy'     
  end
  resources :login

  resources :login, only: [:index, :create, :destroy]

  root 'login#index'

end
