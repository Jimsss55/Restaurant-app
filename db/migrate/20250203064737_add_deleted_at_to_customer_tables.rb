class AddDeletedAtToCustomerTables < ActiveRecord::Migration[8.0]
  def change
    add_column :customer_tables, :deleted_at, :datetime
  end
end
