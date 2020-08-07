class AddItemTransactionToAddresses < ActiveRecord::Migration[6.0]
  def change
    add_reference :addresses, :item_transaction, null: false, foreign_key: true
  end
end
