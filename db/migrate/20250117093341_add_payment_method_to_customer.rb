class AddPaymentMethodToCustomer < ActiveRecord::Migration[8.0]
  def change
    add_column :customers, :payment_method, :string
  end
end
