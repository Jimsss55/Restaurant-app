class ListMenuItems
  def initialize(params)
    @menu_name_query = params[:menu_name_query]
    @page = params[:page]
  end

  def fetch_menu_items
    if @menu_name_query.present?
      MenuItem.search_by_menu_name(@menu_name_query)
              .paginate(page: @page, per_page: 5)
    else
      MenuItem.paginate(page: @page, per_page: 5)
    end
  end
end
