require 'rails_helper'

RSpec.describe User, type: :model do

  it 'will not create a user if email is missing' do
    user = User.new(password: "password")
    expect(user).to be_invalid
  end

  it 'will not create a user if password is missing' do
    user = User.new(email: "pema@gmail.com")
    expect(user).to be_invalid
  end

  it 'will create a user with valid attributes' do
    user = User.new(email: "pema@gmail.com", password: "password")
    expect(user).to be_valid
  end

  it 'will not create a user with duplicate email' do
    user = User.new(email: "pema@gamil.com", password: "password")
    duplicate_user = User.new(email: "pema@gamil.com", password: "password")
    expect(duplicate_user).not_to be_valid
  end
end
