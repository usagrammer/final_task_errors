class CreateItems < ActiveRecord::Migration[6.0]
  def change
    create_table :items do |t|
      t.string :name, null: false
      t.text :info, null: false
      t.integer :price, null: false
      t.integer :category_key, null: false
      t.integer :sales_status_key, null: false
      t.integer :shipping_fee_status_key, null: false
      t.integer :prefecture_key, null: false
      t.date :delivery_date, null: false
      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end
