require 'rails_helper'

RSpec.describe 'User', type: :feature do
  before(:each) do
    @user = User.create(name: 'John', email: 'john@gmail.com', password: '1234567890',
                        password_confirmation: '1234567890')

    visit new_user_session_path
    fill_in 'Email', with: @user.email
    fill_in 'Password', with: @user.password
    click_button 'Log in'
  end

  describe 'Sign in page' do
    it 'have a welcome message' do
      visit new_user_session_path
      expect(page).to have_content("Welcome #{@user.name}")
    end
  end
end
