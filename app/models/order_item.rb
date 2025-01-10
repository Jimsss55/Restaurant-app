class OrderItem < ApplicationRecord
  belongs_to :customer
  belongs_to :menu_item

  validates :quantity, presence: true, numericality: {greater_than_or_equal_to: 1}
end
