require 'rails_helper'

RSpec.describe CustomersController, type: :request do
  let_it_be(:user) { create(:user) }
  let_it_be(:customer_1) { create(:customer) }
  let_it_be(:customer_2) { create(:customer) }
  let_it_be(:customer_3) { create(:customer) }

  before { login_request(user) }

  describe "GET /index" do
    it "renders a successful response" do
      get "/customers.json"
      expect(response).to have_http_status(:success)
    end
  end

  # describe "GET /show" do
  #   it "renders a successful response" do
  #     customer = Customer.create! valid_attributes
  #     get customer_url(customer)
  #     expect(response).to be_successful
  #   end
  # end
  #
  # describe "GET /new" do
  #   it "renders a successful response" do
  #     get new_customer_url
  #     expect(response).to be_successful
  #   end
  # end
  #
  # describe "GET /edit" do
  #   it "renders a successful response" do
  #     customer = Customer.create! valid_attributes
  #     get edit_customer_url(customer)
  #     expect(response).to be_successful
  #   end
  # end
  #
  # describe "POST /create" do
  #   context "with valid parameters" do
  #     it "creates a new Customer" do
  #       expect {
  #         post customers_url, params: { customer: valid_attributes }
  #       }.to change(Customer, :count).by(1)
  #     end
  #
  #     it "redirects to the created customer" do
  #       post customers_url, params: { customer: valid_attributes }
  #       expect(response).to redirect_to(customer_url(Customer.last))
  #     end
  #   end
  #
  #   context "with invalid parameters" do
  #     it "does not create a new Customer" do
  #       expect {
  #         post customers_url, params: { customer: invalid_attributes }
  #       }.to change(Customer, :count).by(0)
  #     end
  #
  #     it "renders a response with 422 status (i.e. to display the 'new' template)" do
  #       post customers_url, params: { customer: invalid_attributes }
  #       expect(response).to have_http_status(:unprocessable_entity)
  #     end
  #   end
  # end
  #
  # describe "PATCH /update" do
  #   context "with valid parameters" do
  #     let(:new_attributes) {
  #       skip("Add a hash of attributes valid for your model")
  #     }
  #
  #     it "updates the requested customer" do
  #       customer = Customer.create! valid_attributes
  #       patch customer_url(customer), params: { customer: new_attributes }
  #       customer.reload
  #       skip("Add assertions for updated state")
  #     end
  #
  #     it "redirects to the customer" do
  #       customer = Customer.create! valid_attributes
  #       patch customer_url(customer), params: { customer: new_attributes }
  #       customer.reload
  #       expect(response).to redirect_to(customer_url(customer))
  #     end
  #   end
  #
  #   context "with invalid parameters" do
  #     it "renders a response with 422 status (i.e. to display the 'edit' template)" do
  #       customer = Customer.create! valid_attributes
  #       patch customer_url(customer), params: { customer: invalid_attributes }
  #       expect(response).to have_http_status(:unprocessable_entity)
  #     end
  #   end
  # end
  #
  # describe "DELETE /destroy" do
  #   it "destroys the requested customer" do
  #     customer = Customer.create! valid_attributes
  #     expect {
  #       delete customer_url(customer)
  #     }.to change(Customer, :count).by(-1)
  #   end
  #
  #   it "redirects to the customers list" do
  #     customer = Customer.create! valid_attributes
  #     delete customer_url(customer)
  #     expect(response).to redirect_to(customers_url)
  #   end
  # end
end
