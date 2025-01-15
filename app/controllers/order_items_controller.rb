require "pry"

class OrderItemsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_customer, only: [ :new, :create, :edit, :destroy ]
  before_action :set_order_item, only: %i[ update edit ]

  # GET /order_items/new
  def new
    @order_item = OrderItem.new
  end

  # POST /order_items or /order_items.json
  def create
    @order_item=@customer.order_items.new(order_item_params)

    if @order_item.save
      flash[:notice] = "Order item was successfully created"
      redirect_to new_customer_order_item_path

    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @order_item.update(order_item_params)
      flash[:notice] = "Order item was successfully updated"
      redirect_to customer_path(@order_item.customer_id)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @order_item = @customer.order_items.find(params[:id])
    @order_item.destroy!
    flash[:notice] = "Order item was successfully destroyed"
    redirect_to customer_path(@order_item.customer_id)
  end

  private
  def set_customer
    @customer = Customer.find(params[:customer_id])
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_order_item
    @order_item = OrderItem.find(params[:id])
  end

  def order_item_params
    params.require(:order_item).permit(:menu_item_id, :quantity)
  end
end
