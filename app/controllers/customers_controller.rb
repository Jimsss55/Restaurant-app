class CustomersController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  before_action :set_customer, only: %i[ show destroy ]

  def index
    @customers = Customer.all
  end
  # GET /customers/1 or /customers/1.json
  def show
  end

  # GET /customers/new
  def new
    @customer = Customer.new
  end

  # POST /customers or /customers.json
  def create
    @customer = Customer.new(customer_params)
    if @customer.save
      flash[:notice] = "Customer was successfully created"
      redirect_to @customer
    else
      render :new, status: :unprocessable_entity
    end
  end

  # DELETE /customers/1 or /customers/1.json
  def destroy
    @customer.destroy!
    flash[:notice] = "Customer was successfully destroyed"
    # redirect_to customer_table_path
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_customer
      @customer = Customer.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def customer_params
      params.require(:customer).permit(:customer_name, :customer_table_id)
    end
end
