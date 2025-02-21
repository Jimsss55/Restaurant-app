class CustomersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_customer, only: %i[ show ]
  before_action :get_source, only: [ :new, :create ]

  SORTABLE_COLUMNS = %w[customer_name payment_amt].freeze

  def index
    date_query = params[:date_query]
    name_query = params[:name_query]

    def sort_column
      params[:sort] if SORTABLE_COLUMNS.include?(params[:sort])
    end

    sort_direction = params[:direction].presence_in(%w[asc desc])

    if name_query.present? && date_query.present?
      @customers = Customer.order(Arel.sql("#{sort_column} #{sort_direction}"))
                          .search_by_name(params[:name_query])
                          .search_by_date(params[:date_query])
                          .paginate(page: params[:page], per_page: 4)
    elsif date_query.present?
      @customers = Customer.order(Arel.sql("#{sort_column} #{sort_direction}"))
                           .search_by_date(params[:date_query])
                           .paginate(page: params[:page], per_page: 4)
    elsif name_query.present?
      @customers = Customer.order(Arel.sql("#{sort_column} #{sort_direction}"))
                           .search_by_name(params[:name_query])
                           .paginate(page: params[:page], per_page: 4)
    else
      if params[:name_query].nil? && params[:date_query].nil?
        @customers = Customer.order(created_at: :desc).paginate(page: params[:page], per_page: 4)

        respond_to do |format|
          format.html
          format.json {
            render json: CustomerSerializer.new(@customers).serializable_hash.to_json
          }
        end
      else
        @customers = Customer.order(Arel.sql("#{sort_column} #{sort_direction}")).paginate(page: params[:page], per_page: 4)
      end
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
    @customer.payment_amt = 0.0

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
