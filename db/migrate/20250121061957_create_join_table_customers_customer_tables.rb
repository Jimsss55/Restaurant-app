class CreateJoinTableCustomersCustomerTables < ActiveRecord::Migration[8.0]
  def change
    create_join_table :customers, :customer_tables do |t|
      t.index :customer_id
      t.index :customer_table_id
    end
  end
end
