class Address < ApplicationRecord
  # <<アソシエーション>>
  belongs_to :item
end
