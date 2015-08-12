class PantryIngredientsController < ApplicationController

  def create
    pantry_ingredient = PantryIngredient.new(pantry_ingredient_params)
    pantry_ingredient.pantry = pantry
    if pantry_ingredient.save
      redirect_to pantry_path
    else
      flash[:warning] = 'Item Was Not Added To Pantry'
      redirect_to pantry_path
    end
  end

  private

  def pantry_ingredient_params
    params.require(:pantry_ingredient).permit(:ingredient_id, :quantity)
  end
end
