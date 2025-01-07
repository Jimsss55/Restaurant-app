FactoryBot.define do
  factory :user do
    #Devise

    email { Faker::Internet.email }
    password { "password" }
    password_confirmation { "password" }
  end
end
