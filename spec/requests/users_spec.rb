require 'rails_helper'

RSpec.describe UsersController, type: :request do
  describe "GET /sign_in" do
    let_it_be(:user_1) { create(:user) }

    before do
      sign_in user_1, scope: :user
    end

    it 'Sign in user successfully and go to customers page' do
      get "/customers.json"
      expect(response).to have_http_status(:success)
      expect(cookies['_restaurant_app_session']).to be_present
    end
  end
end
