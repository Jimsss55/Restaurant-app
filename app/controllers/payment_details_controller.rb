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
    @payment_detail.payment_amt = @total_payment

    if params[:payment_detail][:journal_number].present?
      @customer.payment_method = params[:payment_detail][:journal_number].to_s
    else
      @customer.payment_method = "Cash"
    end

    if @payment_detail.save
      PaymentMailer.payment_detail_email(@customer, @payment_detail).deliver_now
      @customer.update(payment_status: "Payment Done")
      @customer.update(payment_method: params[:payment_detail][:journal_number])
      flash[:notice] = "Payment detail was successfully created and emailed to the customer"
      redirect_to customers_path
    else
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
      params.require(:payment_detail).permit(:email)
    end
    def online_payment
      params[:commit] == "Online Payment"
    end
end
