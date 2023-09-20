class TablesController < ApplicationController

  before_action :set_table, only: [:edit, :update, :qr_code]
  before_action :restrict_customer_user

  def index
    @tables = current_user.restaurant ? current_user.restaurant.tables : []
  end

  def new
    @table = Table.new
  end

  def create
    @table = Table.new(table_params)
    @table.restaurant_id = current_user.restaurant.id

    if @table.save
      respond_to do |format|
        format.html { redirect_to tables_path, notice: "Table was successfully created... " }
        format.turbo_stream { flash[:now] = "Table was successfully created... " }
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def qr_code
  end

  def update
    if @table.update(table_params)
      respond_to do |format|
        format.html { redirect_to tables_path, notice: "Table was successfully updated..." }
        format.turbo_stream { flash[:now] = "Table was successfully updated..." }
      end
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_table
    @table = Table.friendly.find(params[:id])
  end

  def table_params
    params.require(:table).permit(:title, :description, :restaurant_id, :qrcode)
  end
end
