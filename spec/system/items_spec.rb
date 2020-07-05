require 'rails_helper'

RSpec.describe '商品出品', type: :system do
  before do
    @user = FactoryBot.create(:user)
    @item = FactoryBot.build(:item)
  end
  context '商品出品ができるとき' do 
    it '有効な情報を入力すると、レコードが1つ増え、トップページへ遷移すること' do
      # ログインする
      visit new_user_session_path
      fill_in 'user[email]', with: @user.email
      fill_in 'user[password]', with: @user.password
      find('input[name="commit"]').click
      expect(current_path).to eq root_path
      # 出品ページへのリンクがある
      expect(page).to have_content('出品する')
      # 出品ページへのリンクをクリックする
      visit new_item_path
      # フォームに情報を入力する
      page.attach_file('item[image]', "#{Rails.root}/spec/fixtures/sample.png")
      fill_in 'item[name]', with: @item.name
      fill_in 'item[info]', with: @item.info
      select "レディース", from: "item[category_id]"
      select "新品、未使用", from: "item[sales_status_id]"
      select "着払い(購入者負担)", from: "item[shipping_fee_status_id]"
      select "北海道", from: "item[prefecture_id]"
      select "1~2日で発送", from: "item[scheduled_delivery_id]"
      fill_in 'item[price]', with: @item.price
      # 出品ボタンを押すとアイテムモデルのカウントが1上がる
      expect{
        find('input[name="commit"]').click
      }.to change { Item.count }.by(1)
      # トップページへ遷移する
      expect(page).to have_current_path(root_path)
    end
  end
end