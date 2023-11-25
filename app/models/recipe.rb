class Recipe < ApplicationRecord
  belongs_to :user
  has_many :recipe_foods, dependent: :destroy
  has_many :foods, through: :recipe_foods
  before_create :set_default_public_status
  scope :public_recipes, -> { where(public: true) }

  def toggle_public_status_and_visibility
    update(public: !public)

    if public
      add_to_public_category
    else
      remove_from_public_category
    end
  end

  private

  def set_default_public_status
    self.public ||= false
  end

  def add_to_public_category
    public_category.recipes << self if public_category
  end

  def remove_from_public_category
    public_category&.recipes&.delete(self)
  end

  def public_category
    @public_category ||= PublicCategory.find_or_create_by(name: 'Public Recipes')
  end
end
