class ShoppingListsController < ApplicationController
  before_action :set_recipe, only: %i[show edit update destroy generate_shopping_list]

  def index
    general_shopping_list
    @total_count = @shopping_list_items.sum { |item| item.quantity.to_i }
    @total_price = @shopping_list_items.sum { |item| item.quantity.to_i * item.price }
  end

  private

  def general_shopping_list
    @shopping_list_items = []

    @foods = current_user.foods

    current_user.recipes.each do |recipe|
      recipe.recipe_foods.includes(:food).each do |recipe_food|
        food = recipe_food.food
        existing_item = @shopping_list_items.find { |item| item.name == food.name }

        if existing_item
          existing_item.quantity += recipe_food.quantity
        else
          new_item = food.dup
          new_item.quantity = recipe_food.quantity
          @shopping_list_items << new_item
        end
      end
    end
  end
end
