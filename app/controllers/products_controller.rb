class ProductsController < ApplicationController

  before_action :set_product, only: [:edit, :update]
  before_action :restrict_customer_user

  def index
    @products = current_user.restaurant ? current_user.restaurant.products : []
  end

  def new
    @product = Product.new
    @categories = current_user.restaurant.categories.order(:title)
  end

  def create
    @product = Product.new(product_params)
    @product.restaurant_id = current_user.restaurant.id

    if @product.save
      respond_to do |format|
        format.html { redirect_to products_path, notice: "Product was successfully saved..." }
        format.turbo_stream { flash[:now] = "Product was successfully saved..." }
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @categories = current_user.restaurant.categories.order(:title)
  end

  def update
    if @product.update(product_params)
      respond_to do |format|
        format.html { redirect_to products_path, notice: "Product was successfully updated..." }
        format.turbo_stream { flash[:now] = "Product was successfully updated..." }
      end
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_product
    @product = Product.find(params[:id])
  end

  def product_params
    params.require(:product).permit(:title, :price, :description, :category_id, :restaurant_id)
  end
end
