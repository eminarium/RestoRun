class UsersController < ApplicationController

  # GET /users/slug/dashboard
  def manager_dashboard
    @restaurant = current_user.restaurant
    @categories = @restaurant ? @restaurant.categories : []
    @products = @restaurant ? @restaurant.products : []
    @tables = @restaurant ? @restaurant.tables : []
  end
end