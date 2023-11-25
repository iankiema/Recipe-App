class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :foods, dependent: :destroy
  has_many :recipes, dependent: :destroy
  has_many :recipe_foods, dependent: :destroy
  has_one :shopping_list
  has_many :shopping_lists

  attribute :name, :string
  validates :name, presence: true

  def admin?
    role == 'admin'
  end
end
