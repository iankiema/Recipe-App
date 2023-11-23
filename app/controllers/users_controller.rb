class UsersController < ApplicationController
  before_action :set_user, only: %i[show edit update]
  before_action :authenticate_user!, except: [:destroy]
  skip_before_action :set_user, only: [:destroy]

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

  def destroy
    @user = current_user
    @user&.destroy # Assuming you are using Devise for authentication
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
