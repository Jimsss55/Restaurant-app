class MenuItemsController < ApplicationController
  before_action :authenticate_user!, except: [ :index ]
  before_action :set_menu_item, only: %i[ edit update destroy]

  # GET /menu_items or /menu_items.json
  def index
    @menu_items = MenuItem.paginate(page: params[:page], per_page: 5)
  end

  # GET /menu_items/new
  def new
    @menu_item = MenuItem.new
  end


  # POST /menu_items or /menu_items.json
  def create
    @menu_item = MenuItem.new(menu_item_params)

    if @menu_item.save
      flash.now[:notice] ="Menu item was successfully created."
      redirect_to menu_items_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  # GET /menu_items/1/edit
  def edit
  end

  # PATCH/PUT /menu_items/1 or /menu_items/1.json
  def update
    if @menu_item.update(menu_item_params)
      flash.now[:notice] = "Menu Item was successfully updated."
      redirect_to menu_items_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /menu_items/1 or /menu_items/1.json
  def destroy
    @menu_item.destroy!

    respond_to do |format|
      format.html do
        flash[:notice] = "Menu item was successfully deleted."
        redirect_to menu_items_path
      end
      format.turbo_stream
    end
    # flash[:notice] = "Menu item was successfully deleted."
    # redirect_to menu_items_path
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_menu_item
      @menu_item = MenuItem.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def menu_item_params
      params.require(:menu_item).permit(:menu_items, :menu_item_price)
    end
end
