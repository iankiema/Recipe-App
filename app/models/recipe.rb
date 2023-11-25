class Recipe < ApplicationRecord
  belongs_to :user
  has_many :recipe_foods, dependent: :destroy
  has_many :foods, through: :recipe_foods
  before_create :set_default_public_status
  scope :public_recipes, -> { where(public: true) }

  def toggle_public_status_and_visibility
    update(public: !public)

    if public
      PublicRecipe.add_recipe(self)
    else
      PublicRecipe.remove_recipe(self)
    end
  end

  private

  def set_default_public_status
    self.public ||= false
  end
end
