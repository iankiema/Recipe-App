class UsersController < ApplicationController
  before_action :set_user, only: %i[show edit update destroy]

  def show
    # Show user profile
  end

  def edit
    # Edit user profile
  end

  def create
    @user = User.new(user_params)
  end

  def update
    if @user.update(user_params)
      redirect_to @user, notice: 'User profile was successfully updated.'
    else
      render :edit
    end
  end

  # def destroy
  #   @user = @user.id
  #   @user.destroy
  #   redirect_to root_path, notice: 'Your account has been successfully deleted.'
  # end

  def destroy
    current_user.destroy # Assuming you are using Devise for authentication
    sign_out # This signs out the current user
    redirect_to root_path, notice: 'Your account has been successfully deleted.'
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name)
  end
end
