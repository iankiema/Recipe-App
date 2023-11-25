class FoodsController < ApplicationController
  include ActionView::Helpers::NumberHelper

  before_action :set_food, only: %i[show edit update destroy]

  def index
    @foods = current_user.foods
  end

  def show; end

  def new
    @food = Food.new
  end

  def create
    @food = current_user.foods.new(food_params)
    if @food.save
      redirect_to foods_url, notice: 'Food item was successfully created.'
    else
      flash.now[:alert] = 'Food item could not be created.'
      render :new
    end
  end

  def edit; end

  def update
    if @food.update(food_params)
      redirect_to @food, notice: 'Food was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @food = Food.find(params[:id])
    @food.destroy
    redirect_to foods_url, notice: 'Food item was successfully deleted.'
  end

  private

  def set_food
    @food = Food.find(params[:id])
  end

  def food_params
    params.require(:food).permit(:name, :measurement_unit, :price, :quantity)
  end
end
