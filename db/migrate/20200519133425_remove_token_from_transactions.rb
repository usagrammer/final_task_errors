class RemoveTokenFromTransactions < ActiveRecord::Migration[6.0]
  def change

    remove_column :transactions, :token, :string
  end
end
