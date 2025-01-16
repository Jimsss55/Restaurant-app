class CreatePaymentDetails < ActiveRecord::Migration[8.0]
  def change
    create_table :payment_details do |t|
      t.belongs_to :customer
      t.float :payment_amt
      t.string :email
      t.timestamps
    end
  end
end
