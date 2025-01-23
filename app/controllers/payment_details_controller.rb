class PaymentDetailsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_customer, only: %i[ new create]

  def new
    @payment_detail = PaymentDetail.new

    @order_items = @customer.order_items.includes(:menu_item)
    @total_payment = @order_items.sum("menu_item_price * quantity")

    @source = "payment_detail"
    @payment = params[:payment]
  end

  def create
    @payment_detail = @customer.build_payment_detail(payment_detail_params)
    @order_items = @customer.order_items.includes(:menu_item)
    total_payment = @order_items.sum("menu_item_price * quantity")
    @payment_detail.payment_amt = total_payment.to_f

    if @payment_detail.save
      @customer.update(payment_status: "Payment Done", payment_method: params[:payment_detail][:journal_number].presence || "Cash")
      if @customer.payment_status == "Payment Done"
        flash[:notice] = "Payment detail wasq successfully created and emailed to the customer"
        PaymentMailer.payment_detail_email(@customer, @payment_detail).deliver_now
        redirect_to customers_path
      else
        flash[:alert] = "Payment detail could not be created"
        redirect_to customers_path
      end
    else
      @order_items = @customer.order_items.includes(:menu_item)
      @total_payment = @order_items.sum("menu_item_price * quantity")
      @payment_detail.payment_amt = @total_payment

      render :new, status: :unprocessable_entity
    end
  end

  private
    def set_payment_detail
      @payment_detail = PaymentDetail.find(params[:id])
    end

    def set_customer
      @customer = Customer.find(params[:customer_id])
    end

    def payment_detail_params
      params.require(:payment_detail).permit(:email, :journal_number)
    end
    def online_payment
      params[:commit] == "Online Payment"
    end
end
