require 'rails_helper'

describe 'user can log in', type: :feature do
  include Capybara::DSL

  let(:user) { User.create(uid: '123456', name: 'Grumby', token: '1111') }

  before(:each) do
    Capybara.app = PantryRaid::Application
    stub_omniauth_user
    user
  end

  it 'user can login using facebook' do
    visit root_path
    assert_equal 200, page.status_code
    click_on "Login"
    assert_equal '/profile', current_path
    assert page.has_content?("This Week's Menu")
  end

end
