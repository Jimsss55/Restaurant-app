class CreateCustomers < ActiveRecord::Migration[8.0]
  def change
    create_table :customers do |t|
      t.belongs_to :customer_table
      t.string :customer_name
      t.timestamps
    end
  end
end
