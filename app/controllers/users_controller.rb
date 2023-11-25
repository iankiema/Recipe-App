class UsersController < ApplicationController
  before_action :set_user, only: %i[show edit update destroy]

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def show
    return unless @user.nil? || @user == current_user

    # Handle sign-out scenario
    redirect_to new_user_session_path, notice: 'Signed out successfully.'
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
    redirect_to users_url, notice: 'Your account has been successfully deleted.'
  end

  private

  def set_user
    if params[:id] == 'sign_out'
      # No need to find a user when signing out
      sign_out(current_user) if current_user
      @user = nil
    else
      @user = User.find(params[:id])
    end
  end

  def user_params
    params.require(:user).permit(:name)
  end
end
