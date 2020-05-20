class CreateTransactions < ActiveRecord::Migration[6.0]
  def change
    create_table :transactions do |t|

      t.references    :item,     foreign_key: true
      t.references    :user,     foreign_key: true

      t.timestamps
    end
  end
end
