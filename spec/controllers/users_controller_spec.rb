require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  before(:each) do
    @current_user = User.create(uid: '10153014679262644', 
				image_url: 'http://graph.facebook.com/10153014679262644/picture?type=large')
  end

  context '#show' do
    it 'renders the show' do
      get :show

      expect(response.status).to eq(200)
    end
  end
end
