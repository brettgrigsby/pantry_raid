class RecipeIngredientsController < ApplicationController

  before_action :load_recipe

  def new
    @recipe_ingredient = RecipeIngredient.new
  end

  def create
    recipe_ingredient = RecipeIngredient.new(recipe_ingredient_params)
    recipe_ingredient.recipe = @recipe
    if recipe_ingedient.save
      redirect_to new_recipe_recipe_step_path @recipe
    else
      render :new
    end
  end

  private

  def load_recipe
    @recipe = Recipe.find params[:recipe_id]
  end
end
