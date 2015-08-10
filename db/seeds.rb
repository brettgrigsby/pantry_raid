# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


ingredients_list = {	'milk' => 'cup(s)', 'cheese' => 'oz', 'whole chicken' => 'lbs', 'white bread' => 'slices', 'butter' => 'Tbsp',
			'black beans' => 'oz', 'pinto beans' => 'oz', 'kidney beans' => 'oz', 'refried beans' => 'oz', 
			'white rice' => 'cup(s)', 'brown rice' => 'cup(s)', 'spaghetti' => 'lbs', 'fettuccini' => 'lbs',
			'penne' => 'lbs', 'crackers' => 'oz', 'bread crumbs' => 'cup(s)', 'tomatoes' => nil, 'canned tomatoes' => 'oz',
			'tomato sauce' => 'oz', 'salsa' => 'oz', 'green beans' => 'lbs', 'carrots' => nil, 'mushrooms' => 'oz',
			'apples' => nil, 'oranges' => nil, 'peppers' => nil, 'onions' => nil, 'potatoes' => nil, 'garlic' => 'clove(s)',
			'chicken broth' => 'oz', 'beef broth' => 'oz', 'canned tuna' => 'oz', 'ground beef' => 'lbs',
			'ground turkey' => 'lbs', 'ground pork' => 'lbs', 'chicken breast' => 'lbs', 'vinegar' => 'cup(s)',
			'olive oil' => 'Tbsp', 'vegetable oil' => 'Tbsp', 'flour' => 'cup(s)', 'sugar' => 'cup(s)'}

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


