class CustomersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_customer, only: %i[ show ]
  before_action :get_source, only: [ :new, :create ]

  def index
    date_query = params[:date_query]
    name_query = params[:name_query]

    if date_query.present?
      @customers = Customer.order(created_at: :desc).search_by_date(params[:date_query]).paginate(page: params[:page], per_page: 4)
    elsif name_query.present?
      @customers = Customer.order(created_at: :desc).search_by_name(params[:name_query]).paginate(page: params[:page], per_page: 4)
    else
      @customers = Customer.order(created_at: :desc).paginate(page: params[:page], per_page: 4)
    end
  end

  def show
    @order_items = @customer.order_items.includes(:menu_item)
    @grand_total = @order_items.sum("menu_item_price * quantity")
    @payment = params[:payment]
  end

  # GET /customers/new
  def new
    @customer = Customer.new
    @source = params[:source]
  end

  # POST /customers or /customers.json
  def create
    @customer = Customer.new(customer_params)

    if params[:customer][:customer_table_ids].present?
      table_ids = params[:customer][:customer_table_ids].reject(&:blank?)
      @customer.customer_tables = CustomerTable.where(id: table_ids)
      @customer.customer_table = nil
    else

      @customer.customer_table = CustomerTable.find(params[:customer][:customer_table_id])
      @customer.customer_tables.clear
    end

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
      params.require(:customer).permit(:customer_name, :customer_table_id, customer_table_ids: [])
    end

    def get_source
      @source = params[:source]
    end
end
