class Menu < ActiveRecord::Base
  belongs_to :user
  has_many :menu_recipes
  has_many :recipes, through: :menu_recipes

  def recipes_for_date(date)
    menu_recipes.where(meal_time: date).map(&:recipe)
  end
end
