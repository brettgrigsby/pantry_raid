class SessionsController < ApplicationController
  skip_before_action :authorize, only: [:create]
  def create
    @user = User.find_or_create_from_oauth(oauth)
    if @user
      session[:user_id] = @user.id
      redirect_to profile_path
    else
      flash[:warning] = 'Login Failed'
      redirect_to root_path
    end
  end

  def destroy
    session.clear
    redirect_to root_path
  end

  private

  def oauth
    request.env['omniauth.auth']
  end
end
