class RecipesController < ApplicationController
  include ActionView::Helpers::NumberHelper

  before_action :set_recipe, only: %i[show edit update destroy]

  def index
    @recipes = Recipe.all
  end

  def show
    @recipe = Recipe.find(params[:id])
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
    @public_recipes = Recipe.where(public: true)
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
    if @recipe.user == current_user
      @recipe.destroy
      redirect_to recipes_url, notice: 'Recipe was successfully destroyed.'
    else
      redirect_to recipes_url, alert: 'You can only destroy your own recipes.'
    end
  end

  def update_public_status
    @recipe = Recipe.find(params[:id])
    @recipe.update(public: params[:public])
    render json: { status: 'success' }
  end

  private

  def set_recipe
    @recipe = if params[:id] == 'public_recipes'
                nil
              else
                Recipe.find(params[:id])
              end
  end

  def recipe_params
    params.require(:recipe).permit(:name, :preparation_time, :cooking_time, :description, :public, :user_id)
  end
end
