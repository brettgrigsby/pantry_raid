class RecipeStepsController < ApplicationController

  before_action :load_recipe

  def new
    @recipe_step = RecipeStep.new
  end

  def create
    recipe_step = RecipeStep.new(recipe_step_params)
    recipe_step.recipe = @recipe
    recipe_step.step_number = (@recipe.recipe_steps.pluck(:step_number).max || 0) + 1
    if recipe_step.save
      redirect_to new_recipe_recipe_step_path @recipe
    else
      render :new
    end
  end

  private

  def recipe_step_params
    params.require(:recipe_step).permit(:body)
  end

  def load_recipe
    @recipe = Recipe.find params[:recipe_id]
  end
end
