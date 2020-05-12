class CreateItems < ActiveRecord::Migration[6.0]
  def change
    create_table :items do |t|
      t.string     :name         , null: false
      t.text       :info         , null: false
      t.integer    :category_id     , null: false
      t.integer    :status_id       , null: false
      t.integer    :burden_id       , null: false
      t.integer    :prefecture_id   , null: false
      t.integer    :delivery_date_id         , null: false
      t.integer    :price        , null: false
      t.timestamps
    end
  end
end
