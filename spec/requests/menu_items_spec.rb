require 'rails_helper'

RSpec.describe MenuItemsController, type: :request do
  let_it_be(:user) { create(:user) }
  let_it_be(:menu_item_1) { create(:menu_item) }
  let_it_be(:menu_item_2) { create(:menu_item) }
  let_it_be(:menu_item_3) { create(:menu_item) }

  before { login_request(user) }

  describe "GET /index" do
    it "Sends a GET request and display all the Menu Items in JSON Format" do
      get '/menu_items.json'
      expect(response).to have_http_status(:success)
      json_response = JSON.parse(response.body)
      response_ids = json_response.pluck("id")
      response_menu_names = json_response.pluck("menu_items")
      expect(response_ids).to contain_exactly(menu_item_1.id, menu_item_2.id, menu_item_3.id)
      expect(response_menu_names).to contain_exactly(menu_item_1.menu_items, menu_item_2.menu_items, menu_item_3.menu_items)
    end

    context "with menu item search" do
      it "Retrieve the name of the searched menu items" do
        get "/menu_items.json?menu_name_query=#{menu_item_1.menu_items[0..3]}"
        expect(response).to have_http_status(:success)
        json_response = JSON.parse(response.body)
        response_id = json_response.pluck("id")
        expect(response_id).to contain_exactly(menu_item_1.id)
      end
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "create a new customers with success response" do
        menu_items_params = {
          menu_items: Faker::Food.unique.dish,
          menu_item_price: Faker::Commerce.price(range: 1..1000)
        }
        expect { post "/menu_items.json", params: { menu_item: menu_items_params } }.to change(MenuItem, :count).by(1)
        expect(response).to have_http_status(:success)
      end
    end

    context "with invalid parameters" do
      it "Will not create a new menu item(null MenuItem price) and will send a 422 status code" do
        menu_item_params = {
          menu_items: Faker::Food.unique.dish
        }
        expect { post "/menu_items.json", params: { menu_item: menu_item_params } }.not_to change(MenuItem, :count)
        json_response = JSON.parse(response.body)
        expect(json_response["error"]).to include("Menu item price can't be blank")
      end
      it "Will not create a new menu item(MenuItem price less than 1) and will send a 422 status code" do
        menu_item_params = {
          menu_items: Faker::Food.unique.dish,
          menu_item_price: 0
        }
        expect { post "/menu_items.json", params: { menu_item: menu_item_params } }.not_to change(MenuItem, :count)
        json_response = JSON.parse(response.body)
        expect(json_response["error"]).to include("Menu item price must be greater than or equal to 1")
      end
      it "Will not create a new menu items(null MenuItem name) and will send a 422 status code" do
        menu_item_params = {
          menu_item_price: Faker::Commerce.price(range: 1..1000)
        }
        expect { post "/menu_items.json", params: { menu_item: menu_item_params } }.not_to change(MenuItem, :count)
        json_response = JSON.parse(response.body)
        expect(json_response["error"]).to include("Menu items can't be blank")
      end
    end
  end

  describe "PATCH /update" do
    context "With valid parameters" do
      let(:new_value) do
        {
          menu_items: Faker::Food.unique.dish,
          menu_item_price: Faker::Commerce.price(range: 1..1000)
        }
      end

      it "Will successfully update a menu item" do
        patch "/menu_items/#{menu_item_1.id}.json", params: { menu_item: new_value }
        menu_item_1.reload
        expect(response).to have_http_status(:success)
        expect(menu_item_1.menu_items).to eq(new_value[:menu_items])
        expect(menu_item_1.menu_item_price).to eq(new_value[:menu_item_price])
      end
    end

    context "with invalid parameters" do
      let(:invalid_attribute) do
        {
          menu_item_price: 0
        }
      end
      it "will render with 422 status code" do
        patch "/menu_items/#{menu_item_1.id}.json", params: { menu_item: invalid_attribute }
        expect(response).to have_http_status(:unprocessable_entity)
        json_response = JSON.parse(response.body)
        expect(json_response["error"]).to include("Menu item price must be greater than or equal to 1")
      end
    end

    context "with invalid MenuItem id" do
      let(:valid_attribute) do
        {
          menu_items: Faker::Food.unique.dish
        }
      end
      it "will not patch update MenuItem and render with 404 not found status code" do
        patch "/menu_items/30.json", params: { menu_item: valid_attribute }
        expect(response).to have_http_status(:not_found)
        json_response = JSON.parse(response.body)
        expect(json_response["error"]).to include("Record not found")
      end
    end
  end

  describe "DELETE /destroy" do
    context "with invalid MenuItem id" do
      it "will not delete a menu item and return 404 status code" do
        expect { delete "/menu_items/999999.json" }.not_to change(MenuItem, :count)
        expect(response).to have_http_status(:not_found)
        json_response = JSON.parse(response.body)
        expect(json_response["error"]).to include("Record not found")
      end
    end

    context "with valid MenuItem id" do
      it "Will delete the requested menu_item and redirect to menu items list" do
        expect { delete "/menu_items/#{menu_item_1.id}.json" }.to change(MenuItem, :count).by(-1)
        expect(response).to have_http_status(:success)
      end
    end
  end
end
