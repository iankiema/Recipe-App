class CreateFoods < ActiveRecord::Migration[7.1]
  def change
    create_table :foods do |t|
      t.string :name
      t.string :measurement_unit
      t.decimal :price, precision: 8, scale: 2
      t.integer :quantity
      t.integer :user_id
      t.timestamps
    end
  end
end
