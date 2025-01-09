class CreateCustomerTables < ActiveRecord::Migration[8.0]
  def change
    create_table :customer_tables do |t|
      t.integer :customer_table_number
      t.timestamps
    end
  end
end
