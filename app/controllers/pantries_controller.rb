class PantriesController < ApplicationController
  def show
    @pantry_ingredient = PantryIngredient.new
  end
end
