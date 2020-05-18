class AddTokenToTransactions < ActiveRecord::Migration[6.0]
  def change
    add_column :transactions, :token, :string, null: false
  end
end
