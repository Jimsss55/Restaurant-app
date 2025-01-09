class CustomerTable < ApplicationRecord
  validates :customer_table_number, uniqueness: true, presence: true, numericality: {
    greater_than_or_equal_to: 1 }
end
