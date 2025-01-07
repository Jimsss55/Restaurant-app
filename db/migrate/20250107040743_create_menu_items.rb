class CreateMenuItems < ActiveRecord::Migration[8.0]
  def change
    create_table :menu_items do |t|
      t.string :menu_items
      t.float :menu_item_price
      t.timestamps
    end
  end
end
