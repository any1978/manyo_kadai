require 'rails_helper'

RSpec.describe 'ユーザ登録・ログイン・ログアウト機能', type: :system do
  # before do
  #   FactoryBot.create(:user)
  #   FactoryBot.create(:second_user)
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
        visit new_session_path
        expect(current_path).to eq new_session_path
      end
    end
  end
end