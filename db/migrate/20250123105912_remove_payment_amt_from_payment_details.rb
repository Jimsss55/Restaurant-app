class RemovePaymentAmtFromPaymentDetails < ActiveRecord::Migration[8.0]
  def change
    remove_column :payment_details, :payment_amt, :float
  end
end
