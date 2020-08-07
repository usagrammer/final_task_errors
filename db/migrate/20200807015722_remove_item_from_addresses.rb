class RemoveItemFromAddresses < ActiveRecord::Migration[6.0]
  def change
    remove_reference :addresses, :item, null: false, foreign_key: true
  end
end
