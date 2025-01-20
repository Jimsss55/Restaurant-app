class CustomersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_customer, only: %i[ show ]

  def index
    @customers = Customer.order(created_at: :desc).search_by_name(params[:query]).paginate(page: params[:page], per_page: 4)
  end

  def show
    @order_items = @customer.order_items.includes(:menu_item)
    @grand_total = @order_items.sum("menu_item_price * quantity")
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


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_customer
      @customer = Customer.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def customer_params
      params.require(:customer).permit(:customer_name, :customer_table_id)
    end
end
