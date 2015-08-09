# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


ingredients_list = {'milk' => 'ml', 'cheese' => 'oz', 'whole chicken' => 'lbs', 'white bread' => 'slices', 'butter' => 'Tbsp'}

ingredients_list.each { |name, quantity_type| Ingredient.create!(name: name, quantity_type: quantity_type) }

recipes_list = [{name: 'grilled cheese',
		description: 'comfort food',
		ingredients: {'white bread' => [2, nil], 'cheese' => [4, 'shredded'], 'butter' => [1, 'softened']},
		steps: {1 => 'butter the bread', 2 => 'heat up the pan', 3 => 'put the cheese in the bread', 4 => 'heat it up'} },
		{name: 'queso dip',
		description: 'eveyone loves dip',
		ingredients: {'cheese' => [16, 'shredded'], 'milk' => [1, nil]},
		steps: {1 => 'shred cheese into microwave safe bowl', 2 => 'add the milk', 3 => 'heat for 2 minutes', 4 => 'stir and eat'}} ]

recipes_list.each do |recipe|
  new_recipe = Recipe.create!(name: recipe[:name], description: recipe[:description])
  recipe[:ingredients].each do |name, quant_and_prep|
    ingredient = Ingredient.find_by(name: name)
    new_recipe.recipe_ingredients.create!(ingredient_id: ingredient.id, quantity: quant_and_prep.first, prep_method: quant_and_prep.last) 
  end
  recipe[:steps].each do |step, body|
    new_recipe.recipe_steps.create!(step_number: step, body: body)
  end
end 


