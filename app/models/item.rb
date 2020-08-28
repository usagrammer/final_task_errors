class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
    # <<アクティブハッシュの設定関連>>
    belongs_to_active_hash :category
    belongs_to_active_hash :sales_status
    belongs_to_active_hash :shipping_fee_status
    belongs_to_active_hash :prefecture
    belongs_to_active_hash :scheduled_delivery

  # <<バリデーション>>

  # 値が入っているか検証
  with_options presence: true do
    validates :images
    validates :name
    validates :info
    validates :price
  end

  # 金額が半角であるか検証
  validates :price, numericality: { with: /\A[0-9]+\z/}

  # 金額の範囲
  validates_inclusion_of :price, in: 300..9_999_999

  # 選択関係で「---」のままになっていないか検証
  with_options numericality: { other_than: 0} do
    validates :category_id
    validates :sales_status_id
    validates :shipping_fee_status_id
    validates :prefecture_id
    validates :scheduled_delivery_id
  end



  # <<アクティブストレージの設定関連>>
  # has_one_attached :image
  has_many_attached :images

  # <<アソシエーション>>
  belongs_to :user
  has_one :item_transaction
end
