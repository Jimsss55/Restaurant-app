class CustomerTable < ApplicationRecord
  has_many :customers
  has_and_belongs_to_many :customers

  validates :customer_table_number, uniqueness: true, presence: true, numericality: {
    greater_than_or_equal_to: 1 }

  def soft_delete
    update(deleted_at: Time.current)
  end

  default_scope { where(deleted_at: nil) }

end
