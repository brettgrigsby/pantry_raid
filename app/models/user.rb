class User < ActiveRecord::Base
  validates :uid, presence: true

  has_many :recipes
  has_one :menu
  has_one :pantry

  def self.find_or_create_from_oauth(oauth)
    user = User.find_or_create_by(uid: oauth.uid)
    user.name      = oauth.info.name
    user.image_url = oauth.info.image
    user.token     = oauth.credentials.token
    user.save
    Menu.create(user_id: user.id) unless user.menu
    Pantry.create(user_id: user.id) unless user.pantry
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
    pi.quantity >= recipe_ingredient.quantity
  end

  def possible?(recipe)
    recipe.recipe_ingredients.each do |ri|
      return false unless self.has?(ri)
    end
  end

  def needed_ingredients
    menu.recipes.map(&:ingredients).flatten.uniq.map(&:name) - pantry.ingredients.map(&:name)
  end
end
