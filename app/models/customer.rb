class Customer < ApplicationRecord
  belongs_to :customer_table, optional: true
  has_and_belongs_to_many :customer_tables
  has_many :order_items, dependent: :destroy
  has_many :menu_items, through: :order_items
  has_one :payment_detail, dependent: :destroy

  validates :customer_name, presence: true

  enum :payment_method, {
    cash: 0,
    online_payment: 1
  }

  def self.search_by_name(name_query)
    if name_query.present?
      where("customer_name LIKE ?", "%#{name_query}%")
    else
      all
    end
  end

  def self.search_by_date(date_query)
    if date_query.present?
      where("DATE(customers.created_at) = ?", date_query)
    else
      all
    end
  end
end
