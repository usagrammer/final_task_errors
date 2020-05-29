class PayForm
  include ActiveModel::Model
  attr_accessor :item_id, :token, :postal_code, :prefecture, :city, :addresses, :building, :phone_number, :user_id

  # <<バリデーション>>
  with_options presence: true do
    validates :item_id
    validates :token, presence: { message: "を正しく入力してください" }
    validates :postal_code, format: { with: /\A\d{3}[-]\d{4}\z/, message: "を正しく入力してください" }
    validates :prefecture
    validates :city
    validates :addresses
    validates :phone_number
    validates :user_id
  end

  def save
    ItemTransaction.create(
      item_id: item_id,
      user_id: user_id,
    )
    Address.create(
      item_id: item_id,
      postal_code: postal_code,
      prefecture: prefecture,
      city: city,
      addresses: addresses,
      building: building,
      phone_number: phone_number,
    )
  end
end
