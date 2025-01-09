require 'rails_helper'

RSpec.describe "customer_tables/edit", type: :view do
  let(:customer_table) {
    CustomerTable.create!()
  }

  before(:each) do
    assign(:customer_table, customer_table)
  end

  it "renders the edit customer_table form" do
    render

    assert_select "form[action=?][method=?]", customer_table_path(customer_table), "post" do
    end
  end
end
