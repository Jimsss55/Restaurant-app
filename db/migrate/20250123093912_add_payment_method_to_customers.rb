class AddPaymentMethodToCustomers < ActiveRecord::Migration[8.0]
  def change
    add_column :customers, :payment_method, :integer, default: 0
  end
end
