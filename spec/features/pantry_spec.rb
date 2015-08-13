require 'rails_helper'

describe 'pantry', type: :feature do
  let(:user)   { User.create(uid: '123456', name: 'Grumby', token: '1111') }
  let(:pantry) { Pantry.create(user_id: user.id) }
  let(:ingredient) { Ingredient.create(name: 'beans', quantity_type: 'oz') }

  before(:each) do
    user
    pantry
    ingredient
  end

  it 'can add ingredients to itself with the ingredient id' do
    expect(pantry.ingredients.size).to eq(0)

    pantry.add_ingredient(ingredient.id, 20)

    expect(pantry.pantry_ingredients.size).to eq(1)
    expect(pantry.pantry_ingredients.first.ingredient_id).to eq(ingredient.id)
    expect(pantry.pantry_ingredients.first.quantity).to eq(20)

    pantry.add_ingredient(ingredient.id, 10)

    expect(pantry.pantry_ingredients.first.quantity).to eq(30)
  end
end


