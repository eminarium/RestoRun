class UsersController < ApplicationController

  # GET /users/slug/dashboard
  def manager_dashboard
    redirect_to restaurants_path if current_user.customer?
    
    @restaurant = current_user.restaurant
    @categories = @restaurant ? @restaurant.categories : []
    @products = @restaurant ? @restaurant.products : []
    @tables = @restaurant ? @restaurant.tables : []
  end
end