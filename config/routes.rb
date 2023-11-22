Rails.application.routes.draw do
  resources :recipes, only: %i[index show new create edit update destroy] do
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
end
