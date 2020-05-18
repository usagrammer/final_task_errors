class CreateAddresses < ActiveRecord::Migration[6.0]
  def change
    create_table :addresses do |t|

      t.integer     :postal_code,     null: false
      t.integer     :prefecture,      null: false
      t.string      :city,            nill: false
      t.string      :addresses,       nill: false
      t.string      :building
      t.references  :item,            null: false, foreign_key: true

      t.timestamps
    end
  end
end
