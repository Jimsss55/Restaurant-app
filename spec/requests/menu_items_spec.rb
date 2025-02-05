require 'rails_helper'

RSpec.describe MenuItemsController, type: :request do
  describe "GET /index" do
    let_it_be(:menu_item_1) { create(:menu_item) }
    let_it_be(:menu_item_2) { create(:menu_item) }
    let_it_be(:menu_item_3) { create(:menu_item) }

    it 'Sends a GET request and display all the Menu Items in JSON Format' do
      get '/menu_items.json'
      expect(response).to have_http_status(:success)
      json_response = JSON.parse(response.body)
      response_ids = json_response.pluck("id")
      response_menu_names = json_response.pluck("menu_items")
      # binding.pry
      expect(response_ids).to contain_exactly(menu_item_1.id, menu_item_2.id, menu_item_3.id)
      expect(response_menu_names).to contain_exactly(menu_item_1.menu_items, menu_item_2.menu_items, menu_item_3.menu_items)
    end

    context 'with menu item search' do

    end
  end
end
