class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions

  # <<バリデーション>>

  # 値が入っているか検証
  with_options presence: true do
    validates :image
    validates :name
    validates :info
    validates :price
  end

  # 選択関係で「---」のままになっていないか検証
  with_options numericality: { other_than: 0, message: "を選択してください" } do
    validates :category_id
    validates :sales_status_id
    validates :shipping_fee_status_id
    validates :prefecture_id
    validates :scheduled_delivery_id
  end

  # <<アクティブハッシュの設定関連>>
  belongs_to_active_hash :category
  belongs_to_active_hash :sales_status
  belongs_to_active_hash :shipping_fee_status
  belongs_to_active_hash :prefecture
  belongs_to_active_hash :scheduled_delivery

  # <<アクティブストレージの設定関連>>
  has_one_attached :image

  #<<アソシエーション>>
  belongs_to :user
  has_one :ItemTransaction
  has_one :address
end
