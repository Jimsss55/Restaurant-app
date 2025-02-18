FactoryBot.define do
  factory :customer do
    customer_name { Faker::Name.name}
  end
end
