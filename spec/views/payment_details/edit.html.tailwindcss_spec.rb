require 'rails_helper'

RSpec.describe "payment_details/edit", type: :view do
  let(:payment_detail) {
    PaymentDetail.create!()
  }

  before(:each) do
    assign(:payment_detail, payment_detail)
  end

  it "renders the edit payment_detail form" do
    render

    assert_select "form[action=?][method=?]", payment_detail_path(payment_detail), "post" do
    end
  end
end
