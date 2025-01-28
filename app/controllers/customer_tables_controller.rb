class CustomerTablesController < ApplicationController
  before_action :authenticate_user!, except: [ :index ]
  before_action :set_customer_table, only: %i[ show edit update destroy ]

  # GET /customer_tables or /customer_tables.json
  def index
    @customer_tables = CustomerTable.paginate(page: params[:page], per_page: 3)
  end

  def show
  end

  # GET /customer_tables/new
  def new
    @customer_table = CustomerTable.new
  end

  # POST /customer_tables or /customer_tables.json
  def create
    @customer_table = CustomerTable.new(customer_table_params)

    if @customer_table.save
      flash[:notice] = "Customer table was successfully created."
      redirect_to customer_tables_path
    else
      render :new, status: :unprocessable_entity
    end
  end


  # GET /customer_tables/1/edit
  def edit
  end

  # PATCH/PUT /customer_tables/1 or /customer_tables/1.json
  def update
    if @customer_table.update(customer_table_params)
      flash[:notice] = "Customer table was successfully updated"
      redirect_to @customer_table

    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /customer_tables/1 or /customer_tables/1.json
  def destroy
    @customer_table.destroy!

    respond_to do |format|
      format.html do
        flash[:notice] = "Customer table was successfully deleted"
        redirect_to customer_tables_path
      end
      format.turbo_stream
    end
    # flash[:notice] = "Customer table was successfully deleted"
    # redirect_to customer_tables_path
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_customer_table
      @customer_table = CustomerTable.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def customer_table_params
      params.require(:customer_table).permit(:customer_table_number)
    end
end
