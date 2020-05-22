class Transaction < ApplicationRecord
  #<<アソシエーション>>
  belongs_to :user
  belongs_to :items
end
