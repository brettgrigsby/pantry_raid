class MenuRecipesController < ApplicationController

  before_action :load_recipe, only: [:new, :create]

  def new
    @days = (0..29).map { |num| Date.today + num }
  end

  def create
    menu_recipe = MenuRecipe.new(menu_recipe_params)
    menu_recipe.menu = menu
    if menu_recipe.save
      redirect_to profile_path
    else
      render :new
    end
  end

  def destroy
    menu_recipe = MenuRecipe.find(params[:id])
    if menu_recipe.destroy
      redirect_to profile_path
    end
  end

  private

  def load_recipe
    @recipe = Recipe.find params[:recipe_id]
  end

  def menu_recipe_params
    params.permit(:recipe_id, :meal_time)
  end
end
