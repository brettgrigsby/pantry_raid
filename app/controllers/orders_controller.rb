class OrdersController < ApplicationController

  def new
    if current_user.needed_ingredients.empty?
      flash[:notice] = 'You Have All The Groceries You Need'
      redirect_to profile_path
    end
  end

  def create
    fm = FormMonster.new
    fm.create_order(params[:email], params[:password], current_user.needed_ingredients)
    redirect_to orders_path
  end

  def index
  end

  def show
    @ingredient_names = current_user.needed_ingredients
    if @ingredient_names.empty?
      flash[:notice] = 'You Have All The Groceries You Need'
      redirect_to profile_path
    end
  end
end
