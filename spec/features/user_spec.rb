require 'rails_helper'

describe 'user', type: :feature do
  let(:user)   { User.create(uid: '123456', name: 'Grumby', token: '1111') }
  let(:pantry) { Pantry.create(user_id: user.id) }
  let(:menu)   { Menu.create(user_id: user.id) }
  let(:ingredient) { Ingredient.create(name: 'beans', quantity_type: 'oz') }
  let(:recipe) { Recipe.create(name: 'hot beans') }

  before(:each) do
    user
    pantry
    menu.menu_recipes.create(recipe_id: recipe.id)
    recipe.recipe_ingredients.create(ingredient_id: ingredient.id, quantity: 1)
    pantry.pantry_ingredients.create(ingredient_id: ingredient.id, quantity: 16)
  end

  it 'can return a list of recipes based on pantry ingredients' do
    expect(user.ready_recipes.first.name).to eq('hot beans')
  end

  it 'returns a sample of ready recipes' do
    expect(user.ready_sample.first.name).to eq('hot beans')
  end

  it 'returns an array of ingredient names for ingredients needed' do
    ingredient_new = Ingredient.create(name: 'cheese')
    recipe_new = Recipe.create(name: 'hot cheese')
    recipe_new.recipe_ingredients.create(ingredient_id: ingredient_new.id, quantity: 2)
    menu.recipes << recipe_new

    expect(user.needed_ingredients).to eq(['cheese'])
  end

end

