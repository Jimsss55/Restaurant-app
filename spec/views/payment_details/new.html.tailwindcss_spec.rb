require 'rails_helper'

RSpec.describe "payment_details/new", type: :view do
  before(:each) do
    assign(:payment_detail, PaymentDetail.new())
  end

  it "renders new payment_detail form" do
    render

    assert_select "form[action=?][method=?]", payment_details_path, "post" do
    end
  end
end
