class MenuItem < ApplicationRecord

  validates :menu_items, presence: true
  validates :menu_item_price, presence: true
end
