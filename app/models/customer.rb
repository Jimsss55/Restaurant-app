class Customer < ApplicationRecord
  belongs_to :customer_table

  validates :customer_name, presence: true
end
