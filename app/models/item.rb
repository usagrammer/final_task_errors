class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  # <<アクティブハッシュの設定関連>>
  belongs_to_active_hash :category
  belongs_to_active_hash :status
  belongs_to_active_hash :shipping_fee
  belongs_to_active_hash :prefecture
  belongs_to_active_hash :delivery_date

  # <<アクティブストレージの設定関連>>
  has_one_attached :image

  #<<アソシエーション>>
  belongs_to :user
  has_one :ItemTransaction
  has_one :address
end
