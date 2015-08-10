class PantryIngredientsController < ApplicationController

  def new
    @pantry_ingredient = PantryIngredient.new
  end

  def create
    pantry_ingredient = PantryIngredient.new(pantry_ingredient_params)
    pantry_ingredient.pantry = pantry
    if pantry_ingredient.save
      redirect_to pantry_path
    else
      render :new
    end
  end

  private

  def pantry_ingredient_params
    params.require(:pantry_ingredient).permit(:ingredient_id, :quantity)
  end
end
