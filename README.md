## rubocop

設定は`.rubocop.yml`を参照。

### チェック
```bash
bundle ex rubocop
```

### チェック＋自動修正
```bash
bundle ex rubocop -a
```

## DB設計

## users table

| Column             | Type               | Options                 |
|--------------------|--------------------|-------------------------|
| id(PK)             | デフォルト         | null: false             |
| nickname           | deviseのデフォルト | null: false,index: true |
| email              | deviseのデフォルト | null: false             |
| encrypted_password | integer            | null: false             |
| first_name         | string             | null: false             |
| last_name          | string             | null: false             |
| first_name_kana    | string             | null: false             |
| last_name_kana     | string             | null: false             |
| birth_date         | integer            | null: false             |

### Association

* has_many :items
* has_many :transactions
* has_many :card

## addresses table

| Column      | Type    | Options           |
|-------------|---------|-------------------|
| postal_code | integer | null: false       |
| prefecture  | integer | null: false       |
| city        | string  | null: false       |
| address     | string  | null: false       |
| building    | string  |                   |
| item_id(FK) | integer | foreign_key: true |

### Association

* belongs_to :items

## items table

| Column                  | Type       | Options           |
|-------------------------|------------|-------------------|
| id(PK)                  | デフォルト | null: false       |
| name                    | string     | null: false       |
| price                   | integer    | null: false       |
| info                    | text       | null: false       |
| delivery_date           | date       | null: false       |
| shipping_fee_status_key | integer    | null: false       |
| prefecture_key          | integer    | null: false       |
| sales_status_key        | integer    | null: false       |
| category_key            | integer    | null: false       |
| user_id(FK)             | integer    | foreign_key: true |


### Association

* belongs_to :user
* has_one :transaction
* has_one :address

## transactions table

| Column      | Type    | Options           |
|-------------|---------|-------------------|
| item_id(FK) | integer | foreign_key: true |
| user_id(FK) | integer | foreign_key: true |

### Association

* belongs_to :item
* belongs_to :user
