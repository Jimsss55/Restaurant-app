require 'rails_helper'

RSpec.describe "User Authentication", type: :feature do
  let(:menu_item_1) { create(:menu_item) }

  it 'User sign up successfully' do
    visit new_user_registration_path

    fill_in "Email", with: "pema@gmail.com"
    fill_in "Password", with: "password"
    fill_in "Confirm Password", with: "password"
    click_button "Sign up"
  end
end
