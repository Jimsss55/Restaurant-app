require 'rails_helper'

RSpec.describe MenuItemsController, type: :request do
  let_it_be(:user) { create(:user) }
  let_it_be(:menu_item_1) { create(:menu_item) }
  let_it_be(:menu_item_2) { create(:menu_item) }
  let_it_be(:menu_item_3) { create(:menu_item) }

  before { login_request(user) }

  describe "GET /index" do

    it 'Sends a GET request and display all the Menu Items in JSON Format' do
      get '/menu_items.json'
      expect(response).to have_http_status(:success)
      json_response = JSON.parse(response.body)
      response_ids = json_response.pluck("id")
      response_menu_names = json_response.pluck("menu_items")
      expect(response_ids).to contain_exactly(menu_item_1.id, menu_item_2.id, menu_item_3.id)
      expect(response_menu_names).to contain_exactly(menu_item_1.menu_items, menu_item_2.menu_items, menu_item_3.menu_items)
    end

    context 'with menu item search' do
      it "Retrieve the name of the searched menu items" do
        get "/menu_items.json?menu_name_query=#{menu_item_1.menu_items[0..3]}"
        expect(response).to have_http_status(:success)
        json_response = JSON.parse(response.body)
        response_id = json_response.pluck("id")
        expect(response_id).to contain_exactly(menu_item_1.id)
      end
    end
  end

  # describe "GET /show" do
  #   it 'Will display particular menu item' do
  #     get menu_item_url(menu_item_1)
  #     binding.pry
  #     expect(response).to have_http_status(:success)
  #   end
  # end

  describe "POST /create" do
    context 'with valid parameters' do
      it "create a new customers with success response" do
        menu_items_params = {
          menu_items: menu_item_1.menu_items,
          menu_item_price: menu_item_1.menu_item_price
        }
        expect { post menu_items_url, params: { menu_item: menu_items_params } }.to change(MenuItem, :count).by(1)
      end
    end
  end

  describe "GET /edit" do
    it "Get a edit page and successful response" do
      get edit_menu_item_path(menu_item_1.id)
      expect(response).to have_http_status(:success)
    end
  end

  describe "PATCH /update" do
    context "With valid parameters" do
      let(:new_value) do
        {
          menu_items: "CheeseBall",
          menu_item_price: 20
        }
      end

      it 'Will successfully update a menu item' do
        patch menu_item_path(menu_item_1), params: { menu_item: new_value }
        menu_item_1.reload
        expect(response).to have_http_status(:found)
        expect(menu_item_1.menu_items).to eq("CheeseBall")
        expect(menu_item_1.menu_item_price).to eq(20)
      end
    end

    context "with invalid patch attributes" do
      let(:invalid_attribute) do
        {
          menu_item_price: 0
        }
      end

      it 'will render with 422 status code' do
        patch menu_item_path(menu_item_1), params: { menu_item: invalid_attribute }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "DELETE /destroy" do
    it "Will delete the requested menu_item and redirect to menu items list" do
      expect { delete menu_item_path(menu_item_1) }.to change(MenuItem, :count).by(-1)
      expect(response).to redirect_to(menu_items_path)
    end
  end
end
