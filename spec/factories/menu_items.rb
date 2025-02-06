FactoryBot.define do
  factory :menu_item do
    menu_items { Faker::Food.unique.dish }
    menu_item_price { Faker::Commerce.price }
  end
end
