class ItemForm
  include ActiveModel::Model
  ## ItemFormクラスのオブジェクトがitemモデルの属性を扱えるようにする
  attr_accessor :name, :info, :category_id, :sales_status_id, :shipping_fee_status_id, :prefecture_id, :scheduled_delivery_id, :price, :images, :user_id, :tag_name

  # <<バリデーション（ほぼitem.rbの流用）>>

  # 値が入っているか検証
  with_options presence: true do
    validates :images
    validates :name
    validates :info
    validates :price

  end

  # 金額が半角であるか検証
  validates :price, numericality: { message: 'は半角数字で入力してください' }

  # 金額の範囲
  validates_inclusion_of :price, in: 300..9_999_999, message: 'は300円以上9999999円以下にしてください'

  # 選択関係で「---」のままになっていないか検証
  with_options numericality: { other_than: 0, message: 'を選択してください' } do
    validates :category_id
    validates :sales_status_id
    validates :shipping_fee_status_id
    validates :prefecture_id
    validates :scheduled_delivery_id
  end

  def save
    item = Item.new(
      name: name,
      info: info,
      price: price,
      category_id: category_id,
      sales_status_id: sales_status_id,
      shipping_fee_status_id: shipping_fee_status_id,
      prefecture_id: prefecture_id,
      scheduled_delivery_id: scheduled_delivery_id,
      user_id: user_id,
      images: images)

    if self.tag_name.present?
      ## 同じタグが作成されることを防ぐため、first_or_initializeで既に存在しているかチェックする
      tag = Tag.where(name: self.tag_name).first_or_initialize
      item.tags << tag
    end
    item.save

  end


  def update(params, item)
    ## paramsからtag_nameを除外し、除外したものを変数tag_nameに入れる
    tag_name = params.delete(:tag_name)
    ## tag_nameが空ではない場合はタグを作る。first_or_initializeで重複がないかを確認しておく。
    ## ※先にtagを定義しておかないとrescue内でtagが使えない
    tag = Tag.where(name: tag_name).first_or_initialize if tag_name.present?
    ActiveRecord::Base.transaction do
      tag.save if tag_name.present?
      ## updateに!をつけると失敗したらrescueへ
      item.update!(params)
      ## itemから一旦タグを外す。
      item.item_tag_relations.destroy_all
      ## tag_nameがある場合はタグを付け直す。tag_nameがない場合はタグが0個になる
      ## ※タグがバリデーションに引っかかるとここでrescueへ行く
      item.tags << tag if tag_name.present?
      ## 成功であることを呼び出し元であるコントローラに伝えて終了
      return true
    end
    rescue => e
      ## なんらかのバリデーションに引っかかったとき、フォームオブジェクトへエラーメッセージを足していく

      ## itemのnameとtagのnameでエラーメッセージのキーが重複するため、tagはtag_nameとしておく
      tag.errors.messages[:tag_name] = tag.errors.messages.delete(:name) if tag.present?
      ## itemのエラーメッセージとtagのエラーメッセージを一纏めにする。それぞれハッシュの形式になっている
      error_messages = item.errors.messages.merge(tag&.errors&.messages)
      error_messages.each do |key, message|
        self.errors.add(key, message.first)
      end
      ## 失敗したことを呼び出し元であるコントローラに伝えて終了
      return false
  end
end
