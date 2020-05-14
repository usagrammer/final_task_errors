class RemoveAuthorFromUsers < ActiveRecord::Migration[6.0]
  def change

    remove_column :users, :birthday_year_id, :string
    remove_column :users, :birthday_month_id, :string
    remove_column :users, :birthday_date_id, :string
  end
end
