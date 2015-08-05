class AddPrepMethodToRecipeIngredients < ActiveRecord::Migration
  def change
    add_column :recipe_ingredients, :prep_method, :string
  end
end
