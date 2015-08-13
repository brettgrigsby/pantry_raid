require 'rails_helper'

describe 'user', type: :feature do
  include Capybara::DSL

  let(:user) { User.create(uid: '123456', name: 'Grumby', token: '1111') }

  before(:each) do
    Capybara.app = PantryRaid::Application
    stub_omniauth_user
    user
  end

  it 'can log in and out using facebook' do
    visit root_path

    assert_equal 200, page.status_code

    click_on "Login"

    assert_equal '/profile', current_path
    assert page.has_content?("This Week's Menu")

    click_on "Logout"

    expect(current_path).to eq(root_path)   
  end
end
