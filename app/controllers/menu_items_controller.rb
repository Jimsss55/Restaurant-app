class MenuItemsController < ApplicationController
  before_action :authenticate_user!, except: [ :index ]
  before_action :set_menu_item, only: %i[ show edit update destroy]

  # GET /menu_items or /menu_items.json
  def index
    list_menu_items = ::ListMenuItems.new(params)
    @menu_items = list_menu_items.fetch_menu_items

    respond_to do |format|
      format.html { }

      format.json {
        render json: @menu_items
      }
    end
  end

  def show
    respond_to do |format|
      format.html
      format.json { render json: @menu_item }
    end
  end

  # GET /menu_items/new
  def new
    @menu_item = MenuItem.new
  end


  # POST /menu_items or /menu_items.json
  def create
    @menu_item = MenuItem.new(menu_item_params)
    if @menu_item.save
      respond_to do |format|
        format.html { redirect_to menu_items_path, notice: "Menu item was successfully created." }
        format.json { render json: @menu_item }
      end
    else
      respond_to do |format|
        format.html {   render :new, status: :unprocessable_entity }
        format.json { render json: { error: @menu_item.errors.full_messages }, status: :unprocessable_entity }
      end
    end
  end

  # GET /menu_items/1/edit
  def edit
  end

  # PATCH/PUT /menu_items/1 or /menu_items/1.json
  def update
    if @menu_item.update(menu_item_params)
      respond_to do |format|
        format.html { redirect_to menu_items_path, notice: "Menu Item was successfully updated." }
        format.json { render json: @menu_item }
      end
    else
      respond_to do |format|
        format.html {  render :edit, status: :unprocessable_entity }
        format.json { render json: { error: @menu_item.errors.full_messages }, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /menu_items/1 or /menu_items/1.json
  def destroy
    if @menu_item
      @menu_item.destroy!
      respond_to do |format|
        format.html do
          flash.now[:notice] = "Menu item was successfully deleted."
          redirect_to menu_items_path
        end
        format.turbo_stream
        format.json { render json: @menu_item }
      end
    else
      respond_to do |format|
        binding.pry
        format.json { render json: { error: "Menu Item not Found " }, status: :not_found }
      end
    end
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
