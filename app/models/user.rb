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
    pi.quantity >= recipe_ingredient.quantity
  end

  def possible?(recipe)
    recipe.recipe_ingredients.each do |ri|
      return false unless self.has?(ri)
    end
  end

  def order_for_this_week
    all_ri = menu.recipes.reduce([]) { |group, recipe| group << recipe.recipe_ingredients }.flatten
    newb = Hash.new(0)
    total_needed = all_ri.reduce(Hash.new(0)) do |c, ri| 
      c[ri.id] += ri.quantity
      c
    end
    order = total_needed.map do |ingredient_id, quantity|
      owned = pantry.pantry_ingredients.find_by(ingredient_id: ingredient_id)
      if owned
        needed = quantity - owned.quantity
        needed > 0 ? [ingredient_id, needed] : nil
      else
        [ingredient_id, quantity]
      end
    end.compact
    Ingredient.find(order.map(&:first)).map(&:name)
  end

  def needed_ingredients
    menu.recipes.map(&:ingredients).flatten.uniq.map(&:name) - pantry.ingredients.map(&:name)
  end
end
