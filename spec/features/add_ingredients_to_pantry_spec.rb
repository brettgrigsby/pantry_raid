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

  it 'can add ingredients to the pantry' do
    click_link('My Pantry')

    expect(page).to have_content('Add An Ingredient')

    find("option[value='#{ingredient.id}']").select_option
    fill_in('pantry_ingredient[quantity]', with: '10')
    click_button('Add To Pantry')

    expect(page).to have_css('.pantry-ingredient')
    expect(page).to have_content('10 oz')
  end

end

