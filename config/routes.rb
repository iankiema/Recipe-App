Rails.application.routes.draw do
  get 'recipe_foods/new'
  get 'recipe_foods/create'
  get 'recipe_foods/edit'
  get 'recipe_foods/update'
  get 'recipe_foods/destroy'
  get 'shopping_lists/index'
  devise_for :users
  root "users#index"
  resources :recipes, only: %i[index show new create edit update destroy] do
    resources :recipe_foods
    collection do
      get :public_recipes
    end
    member do
      get 'generate_shopping_list'
    end
    patch 'update_public_status', on: :member
  end
  resources :users, only: %i[new create show edit update destroy]
  resources :recipe_foods, only: [:new, :create, :edit, :update, :destroy]
  resources :foods, only: %i[index show new create edit update destroy]
  resources :shopping_lists, only: :index
end
