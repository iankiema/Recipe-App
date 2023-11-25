class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable
  has_many :foods, dependent: :destroy
  has_many :recipes, dependent: :destroy
  has_many :recipe_foods, dependent: :destroy
  has_one :shopping_list
  has_many :shopping_lists

  def general_shopping_list
    recipe_foods = RecipeFood.joins(recipe: :user).where(users: { id: })
    user_food_ids = foods.pluck(:id)
    missing_food_ids = recipe_foods.pluck(:food_id) - user_food_ids

    Food.where(id: missing_food_ids)
  end

  def admin?
    role == 'admin'
  end
end
