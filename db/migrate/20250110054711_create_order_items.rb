class CreateOrderItems < ActiveRecord::Migration[8.0]
  def change
    create_table :order_items do |t|
      t.belongs_to :menu_item
      t.belongs_to :customer
      t.integer :quantity
      t.timestamps
    end
  end
end
