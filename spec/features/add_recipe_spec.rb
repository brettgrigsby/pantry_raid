require 'rails_helper'

describe 'user', type: :feature do
  include Capybara::DSL

  let(:user)   { User.create(uid: '123456', name: 'Grumby', token: '1111') }
  let(:pantry) { Pantry.create(user_id: user.id) }
  let(:menu)   { Menu.create(user_id: user.id) }
  let(:ingredient) { Ingredient.create(name: 'beans', quantity_type: 'oz') }
  let(:recipe) { Recipe.create(name: 'hot beans') }

  before(:each) do
    Capybara.app = PantryRaid::Application
    stub_omniauth_user
    user
    pantry
    menu.menu_recipes.create(recipe_id: recipe.id)
    recipe.recipe_ingredients.create(ingredient_id: ingredient.id, quantity: 1)

    visit root_path
    click_on "Login"
  end

  it 'can create a recipe' do
    click_link('Recipes')

    expect(page).to have_content('hot beans')

    click_link('CREATE A RECIPE')

    fill_in('Name', with: 'Testipe')

    click_button('Choose Ingredients')

    find("option[value='#{ingredient.id}']").select_option
    fill_in('recipe_ingredient[quantity]', with: '2')
    fill_in('recipe_ingredient[prep_method]', with: 'drained')
    click_button('Add This Ingredient')

    expect(page).to have_css('.panel')
    expect(page).to have_content('2 oz')

    click_link('DONE ADDING INGREDIENTS')

    expect(page).to have_content('Explain This Step')

    fill_in('recipe_step[body]', with: 'Cook that stuff')

    click_button('Add This Step')

    expect(page).to have_css('.recipe-step')
    expect(page).to have_content('Cook that stuff')

    click_link('ALL DONE')

    expect(page).to have_content('Testipe')
    expect(page).to have_content('beans')
    expect(page).to have_content('Cook that stuff')
  end

end


