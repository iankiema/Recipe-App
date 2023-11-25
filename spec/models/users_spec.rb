require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'when user is signed in' do
    let(:user) { User.create(name: 'John') }
    it 'displays the welcome message' do
      sign_in user
      get root_path
      expect(response.body).to include("Welcome #{user.name}")
    end
  end
end
