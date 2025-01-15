require "rails_helper"

RSpec.describe PaymentDetailsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/payment_details").to route_to("payment_details#index")
    end

    it "routes to #new" do
      expect(get: "/payment_details/new").to route_to("payment_details#new")
    end

    it "routes to #show" do
      expect(get: "/payment_details/1").to route_to("payment_details#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/payment_details/1/edit").to route_to("payment_details#edit", id: "1")
    end


    it "routes to #create" do
      expect(post: "/payment_details").to route_to("payment_details#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/payment_details/1").to route_to("payment_details#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/payment_details/1").to route_to("payment_details#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/payment_details/1").to route_to("payment_details#destroy", id: "1")
    end
  end
end
