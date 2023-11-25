class RecipeFoodsController < ApplicationController
  before_action :set_recipe
  before_action :set_recipe_food, only: %i[show edit update destroy]

  def new
    @recipe_food = @recipe.recipe_foods.build
    @foods = Food.all
  end

  def show
    @recipe_food = RecipeFood.find(params[:id])
  end

  def create
    @recipe_food = @recipe.recipe_foods.build(recipe_food_params)

    if @recipe_food.save
      redirect_to @recipe, notice: 'Ingredient was successfully added.'
    else
      render :new
    end
  end

  def edit
    @foods = Food.all
  end

  def update
    if @recipe_food.update(recipe_food_params)
      redirect_to @recipe, notice: 'Ingredient was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @recipe_food = RecipeFood.find(params[:id])

    if @recipe_food.destroy
      redirect_to @recipe_food.recipe, notice: 'Ingredient removed successfully'
    else
      redirect_to root, notice: 'Ingredient cannot remove'
    end
  end

  private

  def set_recipe
    @recipe = Recipe.find(params[:recipe_id])
  end

  def set_recipe_food
    @recipe_food = RecipeFood.find(params[:id])
  end

  def recipe_food_params
    params.require(:recipe_food).permit(:food_id, :quantity)
  end
end
