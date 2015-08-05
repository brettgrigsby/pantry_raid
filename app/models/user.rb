class User < ActiveRecord::Base

  has_many :recipes
  has_one :menu
  has_one :pantry

  def self.find_or_create_from_oauth(oauth)
    user = User.find_or_create_by(uid: oauth.uid)
    user.email     = oauth.info.email
    user.image_url = oauth.info.image
    user.token     = oauth.credentials.token
    user.save
    user
  end

end
