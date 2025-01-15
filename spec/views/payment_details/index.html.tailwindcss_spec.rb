require 'rails_helper'

RSpec.describe "payment_details/index", type: :view do
  before(:each) do
    assign(:payment_details, [
      PaymentDetail.create!(),
      PaymentDetail.create!()
    ])
  end

  it "renders a list of payment_details" do
    render
    cell_selector = 'div>p'
  end
end
