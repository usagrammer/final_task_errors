class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable

  # <<バリデーション>>
  # 疑問：なぜユーザ名の大文字小文字を分けて登録できるようにするのか？一意性に関しては必須機能で言及されていない
  # 想定される質問：「なぜmailアドレスのバリデーションは必要ないんですか？また、テストは書かなければいけないのですか？」
  # 　　　　　　　　→デフォルトで実装されているが、変更することもできるため、変更されていないことを確認するためにテストは必要
  validates :nickname, presence: true, uniqueness: { case_sensitive: true }

  validates :birth_date, presence: true

  # パスワードの英数字混在を否定
  PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i.freeze
  validates_format_of :password, with: PASSWORD_REGEX, message: 'Include both letters and numbers'

  # 全角のひらがなor漢字を使用していないか検証
  with_options presence: true, format: { with: /\A[ぁ-んァ-ン一-龥]+\z/, message: 'Full-width characters' } do
    validates :first_name
    validates :last_name
  end

  # 全角のカタカナを使用していないか検証
  with_options presence: true, format: { with: /\A[\p{katakana}　ー－&&[^ -~｡-ﾟ]]+\z/, message: 'Full-width katakana characters' } do
    validates :first_name_kana
    validates :last_name_kana
  end

  # <<アソシエーション>>
  has_many :items
  has_many :item_transactions
end
