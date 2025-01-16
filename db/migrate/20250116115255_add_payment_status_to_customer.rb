class AddPaymentStatusToCustomer < ActiveRecord::Migration[8.0]
  def change
    add_column :customers, :payment_status, :string
  end
end
