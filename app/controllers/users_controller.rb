class UsersController < ApplicationController

  before_action :restrict_customer_user

  # GET /users/slug/dashboard
  def manager_dashboard
    @restaurant = current_user.restaurant
    @categories = @restaurant ? @restaurant.categories : []
    @products = @restaurant ? @restaurant.products : []
    @tables = @restaurant ? @restaurant.tables : []
  end
end