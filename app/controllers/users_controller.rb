class UsersController < ApplicationController

  # GET /users/slug/dashboard
  def manager_dashboard
    @restaurant = current_user.restaurant
  end
end