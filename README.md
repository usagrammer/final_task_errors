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
- belongs_to :address

## addressテーブル
|Column|Type|Options|
|------|----|-------|
|post_number|integer|null: false|
|prefecture_id|string|null: false|
|city|string|null: false|
|address_number|string|null: false|
|building|string|null: false|
|phone_number|integer|null: false|
|user_id|integer|null: false, foreign_key: true|
### Association
- belongs_to :user

## itemsテーブル
|Column|Type|Options|
|------|----|-------|
|image|string|null: false|
|name|string|null: false|
|info|text|null: false|
|category|string|null: false|
|status|string|null: false|
|price|integer|null: false|
|user_id|integer|null: false, foreign_key: true|
|seller|integer|null: false|
|buyer|integer|null: false|
### Association
- belongs_to :user

## cardsテーブル
|Column|Type|Options|
|------|----|-------|
|card_id|integer|null: false|
|customer_id|integer|null: false|
|user_id|integer|null: false, foreign_key: true|
### Association
- belongs_to :user
- belongs_to :address
