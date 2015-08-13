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
    menu
    pantry
    recipe.recipe_ingredients.create(ingredient_id: ingredient.id, quantity: 1)

    visit root_path
    click_on "Login"
  end

  it 'can add recipes to their menu' do
    click_link('Add To Your Menu')

    expect(current_path).to eq(recipes_path)

    expect(page).to have_css('.recipe-box')

    click_link('ADD TO MENU')

    expect(page).to have_css('.menu-day')
    first('.day-choice').click

    expect(current_path).to eq(profile_path)
    expect(menu.recipes.first.name).to eq('hot beans')

    first('.dropdown-toggle').click
    click_link('remove from menu')

    expect(menu.recipes.empty?).to eq(true) 
  end

  it 'can see a list of groceries needed for their menu' do
        click_link('Add To Your Menu')

    expect(current_path).to eq(recipes_path)

    expect(page).to have_css('.recipe-box')

    click_link('ADD TO MENU')

    expect(page).to have_css('.menu-day')
    first('.day-choice').click

    expect(current_path).to eq(profile_path)
    expect(menu.recipes.first.name).to eq('hot beans')

    click_link 'My Shopping List'

    expect(current_path).to eq(order_path)
    expect(page).to have_content('beans')

    click_link 'I Bought These'

    expect(current_path).to eq(profile_path)

    click_link 'My Shopping List'
    expect(page).to have_content('You Have All The Groceries You Need')
  end
end


