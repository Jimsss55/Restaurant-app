require 'rails_helper'

RSpec.describe "payment_details/show", type: :view do
  before(:each) do
    assign(:payment_detail, PaymentDetail.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
