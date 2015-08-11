class OrdersController < ApplicationController

  def new
    
  end

  def create
    fm = FormMonster.new
    fm.create_order(params[:email], params[:password], current_user.needed_ingredients)
    redirect_to orders_path
  end

  def index
  end
end
