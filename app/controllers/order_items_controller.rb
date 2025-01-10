require 'pry'

class OrderItemsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_order_item, only: %i[ show edit update destroy ]

  # GET /order_items or /order_items.json
  def index
    @order_items = OrderItem.all
  end

  # GET /order_items/1 or /order_items/1.json
  def show
  end

  # GET /order_items/new
  def new
    @customer = Customer.find(params[:customer_id])
    @order_item = OrderItem.new
  end

  # GET /order_items/1/edit
  def edit
  end

  # POST /order_items or /order_items.json
  def create
    @order_item = OrderItem.new(order_item_params)
    # binding.pry

    if @order_item.save
      flash[:notice] = "Order item was successfully created"
      redirect_to customers_path(@customer)

    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /order_items/1 or /order_items/1.json
  def update
    if @order_item.update(order_item_params)
      flash[:notice] = "Order item was successfully updated"
      redirect_to @order_item

    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /order_items/1 or /order_items/1.json
  def destroy
    @order_item.destroy!
    flash[:notice] = "Order item was successfully destroyed"
    redirect_to order_items_path
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order_item
      @order_item = OrderItem.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def order_item_params
      params.require(:order_item).permit(:menu_item_id, :customer_id, :quantity)
    end
end
