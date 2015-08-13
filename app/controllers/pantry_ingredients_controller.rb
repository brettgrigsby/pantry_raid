class PantryIngredientsController < ApplicationController

  def create
    pantry.add_ingredient(params[:pantry_ingredient][:ingredient_id], params[:pantry_ingredient][:quantity].to_i)
    redirect_to pantry_path
  end

  private

  def pantry_ingredient_params
    params.require(:pantry_ingredient).permit(:ingredient_id, :quantity)
  end
end
