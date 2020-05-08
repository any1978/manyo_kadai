require 'rails_helper'

RSpec.describe 'ユーザ登録・ログイン・ログアウト機能', type: :system do
  # before do
  #   @user1 = create(:user, name: '付け加えた名前1', email: 'aaa@aaa.com', password: '00000000', admin: false)
  #   @user2 = create(:user, name: '付け加えた名前2', email: 'bbb@bbb.com', password: '11111111', admin: false)
  # #   FactoryBot.create(:second_user)
  # end
  # let(:user) { FactoryBot.build(:user) }
  describe 'ユーザ登録のテスト' do
    context 'ユーザのデータがなくログインしていない場合' do
      it 'ユーザ新規登録のテスト' do
        visit new_user_path
        fill_in 'user[user_name]', with: 'sample'
        fill_in 'user[email]', with: 'sample@example.com'
        fill_in 'user[password]', with: '00000000'
        fill_in 'user[password_confirmation]', with: '00000000'
        click_on 'Create my account'
        user = User.last
        expect(current_path).to eq user_path(user)
      end
      it 'ログインしていない時はログイン画面に飛ぶテスト' do
        visit tasks_path
        expect(current_path).to eq new_session_path
      end
    end
  end
  describe 'セッション機能のテスト' do
    context 'ユーザのデータがある場合' do
      before do
      create(:user)
      end
      it 'ログインしてマイページに飛べること' do
        visit new_session_path
        # fill_in 'user[user_name]', with: 'sample'
        fill_in 'Email', with: 'sample@example.com'
        fill_in 'Password', with: '00000000'
        # fill_in 'user[password_confirmation]', with: '00000000'
        click_on 'Log in'
        user = User.last
        expect(current_path).to eq user_path(user)
      end
      it '一般ユーザが他人の詳細画面に飛ぶとタスク一覧ページに遷移すること' do
        create(:user, id: 2, email: 'zzz@zzz.com', password: "00000000")
        create(:task, name: '付け加えた名前', description: '付け加えたコンテント1', end_date: '2020/05/10', status: '着手中', priority: 'High')
        visit tasks_path
        # click_on (:name, 'actoryで作ったデフォルトのタイトル1')
        click_on '付け加えた名前', match: :first
        expect(current_path).to eq user_path(user)
      end
      it 'ログアウトができること' do
        visit tasks_path
        click_on 'Logout'
        expect(current_path).to eq new_session_path
      end
    end
  end







end