require 'capybara/poltergeist'

class FormMonster
  INSTACART_URL ='https://www.instacart.com/'
  include Capybara::DSL
  def create_order(email, password, ingredients)
    Capybara.default_driver = :poltergeist
    Capybara.register_driver :poltergeist do |app|
	options = {
		:js_errors => false,
		:timeout => 120,
		:debug => true,
		:phantomjs_options => ['--load-images=no', '--disk-cache=false', '--ignore-ssl-errors=yes'],
		:inspector => true,
	}
	Capybara::Poltergeist::Driver.new(app, options)
    end

    Capybara.app_host = INSTACART_URL

    visit INSTACART_URL if current_url != INSTACART_URL

    if current_url == INSTACART_URL
      click_link('Sign in')

      fill_in 'login_user_email', with: "#{email}"
      fill_in 'user_password', with: password

      click_button 'Login'
      sleep(1)
    end

    ingredients.each do |ingredient|
      visit "store/whole-foods/search/#{ingredient.gsub(' ', '%20')}"
      first('.item').click
      click_button('+ Add to Cart')
    end
  end
end

