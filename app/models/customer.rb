class Customer < ApplicationRecord
  belongs_to :customer_table
  # has_and_belongs_to_many :customer_tables, dependent: :destroy
  has_many :order_items, dependent: :destroy
  has_many :menu_items, through: :order_items
  has_one :payment_detail, dependent: :destroy

  validates :customer_name, presence: true

  def self.search_by_name(query)
    if query.present?
      where("customer_name LIKE ?", "%#{query}%")
    else
      all
    end
  end
end
