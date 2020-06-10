FactoryBot.define do
  factory :item do
    # image
    attached { fixture_file_upload(Rails.root.join('spec', 'fixtures', 'files', 'test.jpg'), 'image/jpg') }
    name { "サンプル商品" }
    info { "サンプル商品の説明" }
    price { 1000 }
    category_id { 1 }
    sales_status_id { 1 }
    shipping_fee_status_id { 1 }
    prefecture_id { 1 }
    scheduled_delivery_id { 1 }
    association :user
  end
end
