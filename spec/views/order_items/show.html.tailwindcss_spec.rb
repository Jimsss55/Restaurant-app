require 'rails_helper'

RSpec.describe "order_items/show", type: :view do
  before(:each) do
    assign(:order_item, OrderItem.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
