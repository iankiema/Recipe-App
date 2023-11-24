# == Schema Information
#
# Table name: foods
#
#  id               :bigint           not null, primary key
#  measurement_unit :string
#  name             :string
#  price            :decimal(, )
#  quantity         :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  user_id          :bigint           not null
#
# Indexes
#
#  index_foods_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class Food < ApplicationRecord
  belongs_to :user
  has_many :recipe_foods, dependent: :destroy
  has_many :recipes, through: :recipe_foods
end
