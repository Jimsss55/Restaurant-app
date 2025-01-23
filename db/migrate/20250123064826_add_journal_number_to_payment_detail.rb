class AddJournalNumberToPaymentDetail < ActiveRecord::Migration[8.0]
  def change
    add_column :payment_details, :journal_number, :string
  end
end
