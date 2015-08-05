class CreatePantryIngredients < ActiveRecord::Migration
  def change
    create_table :pantry_ingredients do |t|
      t.references :pantry, index: true, foreign_key: true
      t.references :ingredient, index: true, foreign_key: true
      t.integer :quantity

      t.timestamps null: false
    end
  end
end
