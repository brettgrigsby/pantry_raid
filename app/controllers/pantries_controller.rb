class PantriesController < ApplicationController
  def show
    @pantry_ingredient = PantryIngredient.new
  end

  def update
    current_user.needed_ingredients.each do |ingredient_name|
      ingredient_id = Ingredient.find_by(name: ingredient_name).id
      pantry.add_ingredient(ingredient_id)
    end
    flash[:notice] = 'Your Pantry Has Been Updated'
    redirect_to profile_path
  end
end
