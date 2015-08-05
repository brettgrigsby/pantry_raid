class UsersController < ApplicationController
  def show
    @days = (0..6).map { |num| Date.today + num }
  end
end
