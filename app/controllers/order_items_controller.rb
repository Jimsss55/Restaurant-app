class OrderItemsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_customer, only: [ :new, :create, :update,  :edit, :destroy, :show ]
  before_action :set_order_item, only: %i[ update edit ]
  before_action :get_params, only: %i[ new create edit update destroy ]

  # GET /order_items/new
  def new
    @order_item = OrderItem.new
  end

  def show
  end

  # POST /order_items or /order_items.json
  def create
    @order_item=@customer.order_items.new(order_item_params)

    if @order_item.save
      @total_payment = @customer.order_items.includes(:menu_item).sum("menu_item_price * quantity")
      @customer.update(payment_amt: @total_payment.to_f)

      flash.now[:notice] = "Order item was successfully created"
      redirect_to customer_path(@customer)

    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    respond_to do |format|
      format.html
      format.turbo_stream
    end
  end

  def update
    if @order_item.update(order_item_params)


        @total_payment = @customer.order_items.includes(:menu_item).sum("menu_item_price * quantity")
        @customer.update(payment_amt: @total_payment.to_f)

        if @source == "payment_detail"
          # respond_to do |format|
          #   format.html do
              flash.now[:notice] = "Payment Order item was successfully updated"
              redirect_to new_customer_payment_detail_path(@customer.id)
            # end
            # format.turbo_stream
          # end
        else
          # respond_to do |format|
          #   format.html do
              flash.now[:notice] = "Order item was successfully updated"
              redirect_to customer_path(@order_item.customer_id)
            # end
            # format.turbo_stream
          # end
        end
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @order_item = @customer.order_items.find(params[:id])
    if @order_item.destroy!
      @total_payment = @customer.order_items.includes(:menu_item).sum("menu_item_price * quantity")
      @customer.update(payment_amt: @total_payment.to_f)

      if @source == "payment_detail"
        respond_to do |format|
          format.html do
            flash[:notice] = "Order item was successfully destroyed from payment"
            redirect_to new_customer_payment_detail_path(@customer)
          end
          format.turbo_stream
        end
      else
        respond_to do |format|
          format.html do
            flash[:notice] = "Order item was successfully destroyed"
            redirect_to customer_path(@order_item.customer_id)
          end
          format.turbo_stream
        end
      end
    end
  end

  private
  def set_customer
    @customer = Customer.find(params[:customer_id])
  end

  def get_params
    @source = params[:source]
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_order_item
    @order_item = OrderItem.find(params[:id])
  end

  def order_item_params
    params.require(:order_item).permit(:menu_item_id, :quantity)
  end
end
