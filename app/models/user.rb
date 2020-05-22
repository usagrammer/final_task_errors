class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable

  # <<バリデーション>>
  validates :nickname, presence: true, uniqueness: true
  # パスワードの文字数制限:7〜50文字
  devise :validatable, password_length: 7..50
  # format: { with: /\A[a-z0-9]+\z/, message: "ユーザー名は半角英数字です"}
  # validates :legacy_code, format: { with: /\A[a-zA-Z]+\z/,
  #   message: "英文字のみが使えます" }

  #<<アソシエーション>>
  has_many :items
  has_many :transactions
end
