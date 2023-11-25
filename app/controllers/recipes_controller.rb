class RecipesController < ApplicationController
  include ActionView::Helpers::NumberHelper

  before_action :set_recipe, only: %i[show edit update destroy generate_shopping_list]

  def index
    @recipes = Recipe.all
  end

  def show
    @recipe = Recipe.includes(:foods).find(params[:id])
    @foods = @recipe.foods
  end

  def new
    @recipe = Recipe.new
  end

  def create
    @recipe = current_user.recipes.build(recipe_params)

    if @recipe.save
      redirect_to @recipe, notice: 'Recipe was successfully created.'
    else
      render :new
    end
  end

  def public_recipes
    @public_recipes = Recipe.includes(:user, :recipe_foods).where(public: true).order('created_at DESC')
  end

  def edit; end

  def update
    if @recipe.update(recipe_params)
      redirect_to @recipe, notice: 'Recipe was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @recipe = current_user.recipes.find(params[:id])

    if @recipe.destroy
      redirect_to recipes_path, notice: 'Recipe deleted successfully'
    else
      redirect_to recipes_path, notice: 'Recipe cannot delete'
    end
  end

  def update_public_status
    @recipe = Recipe.find(params[:id])
    @recipe.update(public: params[:public])
    render json: { status: 'success' }
  end

  def toggle_public_status
    @recipe = Recipe.find(params[:id])
    @recipe.toggle_public_status_and_visibility

    redirect_to @recipe, notice: 'Recipe public status updated successfully.'
  end

  def generate_shopping_list
    @foods = current_user.foods
    update_food_quantities
    filter_negative_quantities
    calculate_total
  rescue StandardError => e
    puts "DEBUG: An error occurred - #{e.message}"
    puts e.backtrace
  end

  private

  def update_food_quantities
    current_user.recipes.each do |recipe|
      update_food_quantity_for_recipe(recipe)
    end
  end

  def update_food_quantity_for_recipe(recipe)
    recipe.recipe_foods.includes(:food).each do |recipe_food|
      food = recipe_food.food
      test = @foods.find { |f| f.name == food.name }

      update_food_quantity(test, recipe_food) if test
    end
  end

  def update_food_quantity(food, recipe_food)
    food.quantity = [0, food.quantity - recipe_food.quantity].max
  end

  def filter_negative_quantities
    @foods.select! { |food| food.quantity.negative? }
    @foods.each { |food| food.quantity *= -1 }
  end

  def calculate_total
    @total = @foods.sum { |food| food.price * food.quantity }
  end

  def set_recipe
    @recipe = if params[:id] == 'public_recipes' || params[:id].nil?
                Recipe.public_recipes.where.not(user: current_user).find(params[:id])
              else
                current_user.recipes.find(params[:id])
              end
  rescue ActiveRecord::RecordNotFound
    flash[:alert] = 'Recipe not found.'
    redirect_to recipes_path
  end

  def recipe_params
    params.require(:recipe).permit(:name, :preparation_time, :cooking_time, :description, :public, :user_id)
  end
end
