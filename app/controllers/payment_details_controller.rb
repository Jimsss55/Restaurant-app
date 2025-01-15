class PaymentDetailsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_payment_detail, only: %i[ show edit update destroy ]

  # GET /payment_details or /payment_details.json
  def index
    @payment_details = PaymentDetail.all
  end

  # GET /payment_details/1 or /payment_details/1.json
  def show
  end

  # GET /payment_details/new
  def new
    @payment_detail = PaymentDetail.new
  end

  # POST /payment_details or /payment_details.json
  def create
    @payment_detail = PaymentDetail.new(payment_detail_params)

    if @payment_detail.save
      flash[:notice] = "Payment detail was successfully created"
      redirect_to @payment_detail
    else
      render :new, status: :unprocessable_entity
    end
  end

  # DELETE /payment_details/1 or /payment_details/1.json
  def destroy
    @payment_detail.destroy!
    flash[:notice] = "Payment detail was successfully destroyed"
    redirect_to customer_payment_detail_path
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_payment_detail
      @payment_detail = PaymentDetail.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def payment_detail_params
      params.require(:payment_details).permit(:customer_id, :payment_amt, :email)
    end
end
