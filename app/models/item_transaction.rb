class ItemTransaction < ApplicationRecord
  # <<アソシエーション>>
  belongs_to :user
  belongs_to :item
  has_one :address, dependent: :destroy
end
