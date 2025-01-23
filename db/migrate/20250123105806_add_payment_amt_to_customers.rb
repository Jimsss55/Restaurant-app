class AddPaymentAmtToCustomers < ActiveRecord::Migration[8.0]
  def change
    add_column :customers, :payment_amt, :float
  end
end
