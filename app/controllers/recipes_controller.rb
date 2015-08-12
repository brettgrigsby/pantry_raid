class RecipesController < ApplicationController

  def show
    @recipe = Recipe.find(params[:id])
  end

  def index
    @recipes = Recipe.all
  end

  def new
    @recipe = Recipe.new
  end

  def create
    recipe = Recipe.new(recipe_params)
    if recipe.save
      redirect_to new_recipe_recipe_ingredient_path recipe
    else
      flash[:warning] = 'Recipe Was Not Created'
      render :new
    end
  end

  def possibilities
  end

  private

  def recipe_params
    params.require(:recipe).permit(:name, :description)
  end
end
