class User < ActiveRecord::Base

  has_many :recipes
  has_one :menu
  has_one :pantry

  def self.find_or_create_from_oauth(oauth)
    user = User.find_or_create_by(uid: oauth.uid)
    user.email     = oauth.info.email
    user.image_url = oauth.info.image
    user.token     = oauth.credentials.token
    user.save
    unless user.menu
      Menu.create(user_id: user.id)
    end
    unless user.pantry
      Pantry.create(user_id: user.id)
    end
    user
  end

  def ready_sample
    ready_recipes.shuffle.first(5)
  end

  def ready_recipes
    all_recipes.select { |recipe| possible?(recipe) }
  end

  def all_recipes
    potential = Recipe.find( pantry.ingredients.joins(:recipes).pluck(:recipe_id).uniq )
    potential.reduce([]) do |collection, recipe|
      (recipe.ingredients - pantry.ingredients).empty? ? collection << recipe : collection
    end
  end

  def has?(recipe_ingredient)
    pi = pantry.pantry_ingredients.find_by(ingredient_id: recipe_ingredient.ingredient_id)
    pi.quantity > recipe_ingredient.quantity
  end

  def possible?(recipe)
    recipe.recipe_ingredients.each do |ri|
      return false unless self.has?(ri)
    end
  end
end
