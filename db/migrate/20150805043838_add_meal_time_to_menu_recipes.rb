class AddMealTimeToMenuRecipes < ActiveRecord::Migration
  def change
    add_column :menu_recipes, :meal_time, :date
  end
end
