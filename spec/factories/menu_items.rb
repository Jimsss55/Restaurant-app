FactoryBot.define do
  factory :menu_item do
    menu_items { Faker::Food.unique.dish }
    menu_item_price { Faker::Commerce.price(range: 1..1000) }
  end
end
