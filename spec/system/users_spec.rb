require 'rails_helper'

RSpec.describe 'ユーザー新規登録', type: :system do
  before do
    @user = FactoryBot.build(:user)
  end
  context 'ユーザー新規登録ができるとき' do 
    it '正しい情報を入力すればユーザー新規登録ができてトップページに移動する' do
      # トップページに移動する
      visit root_path
      # トップページにサインアップページへ遷移するボタンがある
      expect(page).to have_content('新規登録')
      # 新規登録ページへ移動する
      click_on '新規登録'
      # ユーザー情報を入力する
      fill_in 'user[nickname]', with: @user.nickname
      fill_in 'user[email]', with: @user.email
      fill_in 'user[password]', with: @user.password
      fill_in 'user[password_confirmation]', with: @user.password
      fill_in 'user[first_name]', with: @user.first_name
      fill_in 'user[last_name]', with: @user.last_name
      fill_in 'user[first_name_kana]', with: @user.first_name_kana
      fill_in 'user[last_name_kana]', with: @user.last_name_kana
      select "1930", from: "user[birth_date(1i)]"
      select "1", from: "user[birth_date(2i)]"
      select "1", from: "user[birth_date(3i)]"
      # サインアップボタンを押すとユーザーモデルのカウントが1上がる
      expect{
        find('input[name="commit"]').click
      }.to change { User.count }.by(1)
      # トップページへ遷移する
      expect(page).to have_current_path(root_path)
      # 新規登録の文字が消えている ←不要？
      expect(page).to have_no_content('新規登録')
      # 登録したニックネームが表示されている ←不要？
      expect(page).to have_content(@user.nickname)
    end
  end

  context 'ユーザー新規登録ができないとき' do
    it '誤った情報ではユーザー新規登録ができずに新規登録ページへ戻ってくる' do
      # トップページに移動する
      # トップページにサインアップページへ遷移するボタンがある
      # 新規登録ページへ移動する
      # ユーザー情報を入力する
      # サインアップボタンを押してもユーザーモデルのカウントは上がらない
      # 新規登録ページへ戻される
    end
  end
end
