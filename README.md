# DB設計

## usersテーブル
|Column|Type|Options|
|------|----|-------|
|nickname|string|null: false|
|email|string|null: false,unique: true|
|password|string|null: false|
|birth_year|integer|null: false|
|birth_month|integer|null: false|
|birth_day|integer|null: false|
|first_name|string|null: false|
|last_name|string|null: false|
|first_name_kana|string|null: false|
|last_name_kana|string|null: false|
### Association
- has_many :items
- has_many :transactions
- has_one :card

## addressesテーブル
|Column|Type|Options|
|------|----|-------|
|postal_code|integer|null: false| <!-- 郵便番号 -->
|prefecture|intger|null: false| <!-- 都道府県 -enum> 
|city|string|null: false| <!-- 市区町村 -->
|address|string|null: false|　<!-- 住所 -->
|building|string| <!-- 建物名 -->
|user_id|integer|null: false, foreign_key: true|
### Association
- belongs_to :item

## itemsテーブル
|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
|info|text|null: false|
|category|intger|null: false|  <!-- enum -->
|status|intger|null: false|
|price|integer|null: false|
|user_id|integer|null: false, foreign_key: true|
|seller|integer|null: false|
|buyer|integer|
### Association
- belongs_to :user
- belongs_to :transaction
- belongs_to :address

## transactions
|Column|Type|Options|
|------|----|-------|
|transaction_state|integer|null: false|
|user_id	|integer|null: false, foreign_key: true|
|item_id	|integer|null: false, foreign_key: true|
|buyer_id	|integer|foreign_key: true|
### Association
- belongs_to :item
- has_many :users


## cardsテーブル
|Column|Type|Options|
|------|----|-------|
|card_id|string|null: false|
|customer_id|string|null: false|
|user_id|integer|null: false, foreign_key: true|
### Association
- belongs_to :user

