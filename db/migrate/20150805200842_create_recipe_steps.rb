class CreateRecipeSteps < ActiveRecord::Migration
  def change
    create_table :recipe_steps do |t|
      t.integer :step_number
      t.string :body
      t.references :recipe, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
