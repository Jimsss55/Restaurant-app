class Customer < ApplicationRecord
  belongs_to :customer_table
  has_many :order_items
  has_many :menu_items, through: :order_items
  has_one :payment_detail

  validates :customer_name, presence: true
end
