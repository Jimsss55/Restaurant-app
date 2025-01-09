require 'rails_helper'

RSpec.describe "customer_tables/new", type: :view do
  before(:each) do
    assign(:customer_table, CustomerTable.new())
  end

  it "renders new customer_table form" do
    render

    assert_select "form[action=?][method=?]", customer_tables_path, "post" do
    end
  end
end
