class Ingredient < ActiveRecord::Base
  has_many :recipe_ingredients
  has_many :recipes, through: :recipe_ingredients
  has_many :pantry_ingredients
  has_many :pantries, through: :pantry_ingredients

  def form_text
    quantity_type ? "#{name} (#{quantity_type})" : name
  end
end
