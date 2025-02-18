class CustomerSerializer
  include JSONAPI::Serializer
  attributes :id, :customer_table_id, :customer_name, :payment_status, :payment_method, :payment_amt
  # belongs_to :customer_table, optional: true
  # has_and_belongs_to_many :customer_tables
  # has_many :order_items, dependent: :destroy
  # has_many :menu_items, through: :order_items
  # has_one :payment_detail, dependent: :destroy
end
