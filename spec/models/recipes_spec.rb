require 'rails_helper'

RSpec.describe Recipe, type: :model do
  subject(:user) { User.new(name: 'Kiema', email: 'kiema@gmail.com') }

  let!(:recipe) do
    Recipe.create(name: 'Recipe',
                  preparation_time: '1', cooking_time: '1', description: 'Recipe Test', public: true, user_id: user.id)
  end
  describe 'Validations' do
    it 'is not valid without a name' do
      recipe.name = nil
      expect(recipe).to_not be_valid
    end

    it 'is not valid without a preparation_time' do
      recipe.preparation_time = nil
      expect(recipe).to_not be_valid
    end

    it 'is not valid without a cooking_time' do
      recipe.cooking_time = nil
      expect(recipe).to_not be_valid
    end

    it 'is not valid without a description' do
      recipe.description = nil
      expect(recipe).to_not be_valid
    end
  end

  describe 'Associations' do
    it 'has many recipe_foods' do
      expect(recipe.recipe_foods).to be_empty
    end

    it 'has many foods through recipe_foods' do
      expect(recipe.foods).to be_empty
    end
  end
end
