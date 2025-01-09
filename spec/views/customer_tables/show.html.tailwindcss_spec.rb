require 'rails_helper'

RSpec.describe "customer_tables/show", type: :view do
  before(:each) do
    assign(:customer_table, CustomerTable.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
