class CategoriesController < ApplicationController

  before_action :set_category, only: [:edit, :update]

  def index
    @categories = current_user.restaurant.categories
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    @category.restaurant_id = current_user.restaurant.id

    if @category.save
      respond_to do |format|
        format.html { redirect_to categories_path, notice: "Category was successfully added..." }
        format.turbo_stream { flash.now[:notice] = "Category was successfully added..." }
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @category.update(category_params)
      respond_to do |format|
        format.html { redirect_to categories_path, notice: "Category was successfully updated..." }
        format.turbo_stream { flash.now[:notice] = "Category was successfully updated..." }
      end
    else
      render :edit, status: :unprocessable_entity
    end       
  end

  private

  def set_category
    @category = Category.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:title, :description, :restaurant_id)
  end
end
