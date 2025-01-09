require 'rails_helper'

RSpec.describe "customer_tables/index", type: :view do
  before(:each) do
    assign(:customer_tables, [
      CustomerTable.create!(),
      CustomerTable.create!()
    ])
  end

  it "renders a list of customer_tables" do
    render
    cell_selector = 'div>p'
  end
end
