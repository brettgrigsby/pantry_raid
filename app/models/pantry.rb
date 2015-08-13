class Pantry < ActiveRecord::Base
  belongs_to :user
  has_many :pantry_ingredients
  has_many :ingredients, through: :pantry_ingredients

  def add_ingredient(ingredient_id, quantity)
    target = pantry_ingredients.where(ingredient_id: ingredient_id)
    if target.size > 0
      previous_quantity = target.first.quantity
      target.first.update_attributes(quantity: previous_quantity + quantity)
    else
      pantry_ingredients.create(ingredient_id: ingredient_id, quantity: quantity)
    end
  end
end
