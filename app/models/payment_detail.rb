class PaymentDetail < ApplicationRecord
  belongs_to :customer
  validates :email, presence: true,
            format: { with: /\b[A-Z0-9._%a-z\-]+@(?:[A-Z0-9a-z\-]+\.)+[A-Za-z]{2,4}\z/ }

  attr_accessor :journal_number
  #
  # validates :journal_number, presence: true, if: :payment_present?
end
