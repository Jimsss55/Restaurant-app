FactoryBot.define do
  factory :menu_item do
    menu_items { Faker::Food.dish }
    menu_item_price { Faker::Commerce.price }
  end
end
