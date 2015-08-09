class Menu < ActiveRecord::Base
  belongs_to :user
  has_many :menu_recipes
  has_many :recipes, through: :menu_recipes

  def menu_recipes_for_date(date)
    menu_recipes.where(meal_time: date)
  end
end
