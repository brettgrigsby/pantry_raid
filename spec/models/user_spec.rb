require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { User.create(name: 'Brett Grigsby', uid: '123456', token: '1111') }

  it 'is valid' do
    expect(user).to be_valid
  end

  it 'is invalid without a uid' do
    user.uid = nil
    expect(user).not_to be_valid
  end

  it 'can create a user' do
    u = User.find_or_create_from_oauth(stub_omniauth_new_user)

    expect(u.uid).to eq('9999')
    expect(u.name).to eq('Brett Grigsby')
    expect(u.token).to eq('1111')
    expect(u.uid).to_not eq(user.uid)
  end
end
