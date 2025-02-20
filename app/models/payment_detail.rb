class PaymentDetail < ApplicationRecord
  belongs_to :customer
  validates :email, presence: true,
            format: { with: /\A[A-Z0-9._%a-z\-]+@(?:[A-Z0-9a-z\-]+\.)+[A-Za-z]{2,4}\z/ }

  validates :journal_number, uniqueness: true, if: -> { journal_number.present? }
end
