class AddReciepieId < ActiveRecord::Migration[7.1]
  def change
    def change
      add_reference :recipe_foods, :recipes, null: false, foreign_key: true
    end
  end
end
