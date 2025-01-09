class CustomerTable < ApplicationRecord
  validates :customer_table_number, presence: true, numericality: {
    greater_than_or_equal_to: 1 }
end
