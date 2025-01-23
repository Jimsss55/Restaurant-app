class RemovePaymentMethodFromCustomers < ActiveRecord::Migration[8.0]
  def change
    remove_column :customers, :payment_method, :string
  end
end
