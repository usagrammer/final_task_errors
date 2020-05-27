## 環境変数

### PAYJP

bash_profileもしくはzshrcへ追記してください。
記入後は`resources ~/.zshrc`or`resources ~/.bash_profile`で反映しましょう。
もしくは、ターミナルの再起動を行ってください。

```bash
export PAYJP_SK="登録しているPAYJPのSK"
export PAYJP_PK="登録しているPAYJPのPK"
```

### webpackerで環境変数を使用するには

`furima/config/initializers/webpacker.rb`を作成し下記のように記述します。

```ruby
Webpacker::Compiler.env["PAYJP_SK"] = ENV["PAYJP_SK"]
```

あとはjsファイルで下記のように使用するだけです。

```javascript
  const PAYJP_SK = process.env.PAYJP_SK
  Payjp.setPublicKey(PAYJP_SK);
```

こちらの記事を参考にしています。
https://qiita.com/takeyuweb/items/61e6ba07fe0df3079041



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
| phone       | integer | null: false       |
| item_id(FK) | integer | foreign_key: true |

### Association

* belongs_to :items

## items table

| Column                              | Type       | Options           |
|-------------------------------------|------------|-------------------|
| id(PK)                              | デフォルト | null: false       |
| name                                | string     | null: false       |
| price                               | integer    | null: false       |
| info                                | text       | null: false       |
| scheduled_delivery_id(acitve_hash)  | integer    | null: false       |
| shipping_fee_status_id(acitve_hash) | integer    | null: false       |
| prefecture_id(acitve_hash)          | integer    | null: false       |
| sales_status_id(acitve_hash)        | integer    | null: false       |
| category_id(acitve_hash)            | integer    | null: false       |
| user_id(FK)                         | integer    | foreign_key: true |


### Association

* belongs_to :user
* has_one :item_transaction
* has_one :address

## item_transactions table

| Column      | Type    | Options           |
|-------------|---------|-------------------|
| item_id(FK) | integer | foreign_key: true |
| user_id(FK) | integer | foreign_key: true |

### Association

* belongs_to :item
* belongs_to :user
