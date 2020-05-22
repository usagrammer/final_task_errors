class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable

  # <<バリデーション>>
  validates :nickname, presence: true, uniqueness: true

  # パスワードの文字数制限:7〜50文字いないか検証
  devise :validatable, password_length: 7..50
  # 全角のひらがなor漢字を使用していないか検証
  with_options presence: true, format: { with: /\A[ぁ-んァ-ン一-龥]/, message: "全角文字を使用してください" } do
    validates :first_name
    validates :last_name
    validates :first_name_kana
    validates :last_name_kana
  end

  #<<アソシエーション>>
  has_many :items
  has_many :transactions
end
