class PaymentDetail < ApplicationRecord
  validates :email, presence: true, uniqueness: true
  validates :payment_amt, presence: true
  belongs_to :customer
end
