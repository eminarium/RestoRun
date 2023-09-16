class RestaurantsController < ApplicationController

  before_action :set_restaurant, only: [:edit, :update]

  def new
    redirect_to manager_dashboard_path(current_user) if current_user.restaurant.present?
    @restaurant = Restaurant.new
  end

  def edit
  end

  def create
    @restaurant = Restaurant.new(restaurant_params)
    @restaurant.user_id = current_user.id

    if @restaurant.save
      respond_to do |format|
        format.html { redirect_to manager_dashboard_path(current_user), notice: "Restaurant was successfully added..." }
        format.turbo_stream { flash.now[:notice] = "Restaurant was successfully added..." }
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @restaurant.update(restaurant_params)
      respond_to do |format|
        format.html { redirect_to manager_dashboard_path(current_user), notice: "Restaurant was successfully updated..." }
        format.turbo_stream { flash.now[:notice] = "Restaurant was successfully updated..." }
      end
    else
      render :edit, status: :unprocessable_entity
    end    
  end

  private

  def set_restaurant
    @restaurant = Restaurant.find(params[:id])
  end

  def restaurant_params
    params.require(:restaurant).permit(:title, :description, :is_halal, :is_kosher, :is_vegetarian, :user_id)
  end
end
