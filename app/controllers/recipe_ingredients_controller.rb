class RecipeIngredientsController < ApplicationController

  before_action :load_recipe

  def new
    @recipe_ingredient = RecipeIngredient.new
  end

  def create
    recipe_ingredient = RecipeIngredient.new(recipe_ingredient_params)
    recipe_ingredient.recipe = @recipe
    if recipe_ingredient.save
      redirect_to new_recipe_recipe_ingredient_path @recipe
    else
      render :new
    end
  end

  private

  def load_recipe
    @recipe = Recipe.find params[:recipe_id]
  end

  def recipe_ingredient_params
    params.require(:recipe_ingredient).permit(:ingredient_id, :quantity, :prep_method)
  end
end
