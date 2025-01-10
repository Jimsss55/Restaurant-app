require 'rails_helper'

RSpec.describe "order_items/edit", type: :view do
  let(:order_item) {
    OrderItem.create!()
  }

  before(:each) do
    assign(:order_item, order_item)
  end

  it "renders the edit order_item form" do
    render

    assert_select "form[action=?][method=?]", order_item_path(order_item), "post" do
    end
  end
end
