require "rails_helper"

RSpec.describe CustomerTablesController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/customer_tables").to route_to("customer_tables#index")
    end

    it "routes to #new" do
      expect(get: "/customer_tables/new").to route_to("customer_tables#new")
    end

    it "routes to #show" do
      expect(get: "/customer_tables/1").to route_to("customer_tables#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/customer_tables/1/edit").to route_to("customer_tables#edit", id: "1")
    end


    it "routes to #create" do
      expect(post: "/customer_tables").to route_to("customer_tables#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/customer_tables/1").to route_to("customer_tables#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/customer_tables/1").to route_to("customer_tables#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/customer_tables/1").to route_to("customer_tables#destroy", id: "1")
    end
  end
end
