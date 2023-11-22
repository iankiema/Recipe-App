# == Schema Information
#
# Table name: recipes
#
#  id               :bigint           not null, primary key
#  cooking_time     :integer
#  description      :text
#  name             :string
#  preparation_time :integer
#  public           :boolean
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  user_id          :bigint           not null
#
# Indexes
#
#  index_recipes_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class Recipe < ApplicationRecord
  belongs_to :user
  has_many :recipe_foods, dependent: :destroy
  has_many :foods, through: :recipe_foods
end
