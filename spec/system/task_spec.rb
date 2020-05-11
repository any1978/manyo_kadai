require 'rails_helper'

RSpec.describe 'タスク管理機能', type: :system do
before do
  #ユーザー
  user1 = FactoryBot.create(:user)
  # binding.irb
  user2 = FactoryBot.create(:second_user)

  #タスク
  task1 = FactoryBot.create(:task, user: user1)
  task2 = FactoryBot.create(:second_task, user: user1)
  task3 = FactoryBot.create(:third_task, user: user1)

  #ラベル
  label1 = FactoryBot.create(:label1)
  label2 = FactoryBot.create(:label2)

  #ラベリング
  Labelling.create(task_id: task1.id, label_id: label1.id)
  Labelling.create(task_id: task2.id, label_id: label2.id)

  #ログイン
  visit root_path
  fill_in 'Email', with: 'sample@example.com'
  fill_in 'Password', with: '00000000'
  click_on 'Log in'
end

  describe 'タスク一覧画面' do
    context 'タスクを作成した場合' do
      it '作成済みのタスクが表示される' do
        visit tasks_path
        expect(page).to have_content 'sampleタイトル'
      end
    end
    context '複数のタスクを作成した場合' do
      it 'タスクが作成日時の降順に並んでいる' do
        visit tasks_path
        task_list = all('.task_row') 
        expect(task_list[0]).to have_content 'sampleタイトル3'
        expect(task_list[1]).to have_content 'sampleタイトル2'
      end
    end
    context 'ソートボタンをクリックした場合' do
      it '終了期限の並び替えができる' do
        visit tasks_path
        click_on "▲", match: :first
        expect(page).to have_content 'タスク一覧'
        task_list = all('.task_row') 
        sleep 1
        expect(page).to have_content 'タスク一覧'
        expect(task_list[0]).to have_content 'sampleタイトル1'
        visit tasks_path
        click_on '▼', match: :first
        expect(page).to have_content 'タスク一覧'
        task_list = all('.task_row')
        expect(task_list[0]).to have_content 'sampleタイトル3'
      end
    end
    context '検索をした場合' do
      it "タイトルで検索できる" do
        visit tasks_path
        fill_in "タイトル", with: "sampleタイトル1"
        click_on "検索"
      end
      it "ステータスで検索できる" do
        visit tasks_path
        select "未着手", from: "status"
        click_on "検索"
        expect(page).to have_content "未着手"
      end
      it "ラベルで検索できる" do
        visit tasks_path
        select "0", from: "label_name"
        click_on "検索"
        expect(page).to have_content "0"
      end      
      it "タイトル&ステータス&ラベルで検索できる" do
        visit tasks_path
        fill_in "タイトル", with: "sampleタイトル1"
        select "未着手", from: "status"
        select "0", from: "label_name"
        click_on "検索"
        expect(page).to have_content "sampleタイトル1", "未着手"
        expect(page).to have_content "0"
      end
    end
  end

  describe 'タスク登録画面' do
    context '必要項目を入力して、createボタンを押した場合' do
      it 'データが保存される' do
        visit new_task_path
        fill_in "Name", with: "task"
        fill_in "Description", with: "description"
        fill_in "End date", with: Time.new(2020,5,19)
        select "未着手", from: "Status"
        select "High", from: "Priority"
        check "0"
        # , from: "Label name"
        click_button '登録する'
        expect(page).to have_content "task"
        expect(page).to have_content "2020年05月19日"
        expect(page).to have_content "未着手"
        expect(page).to have_content "High"
        expect(page).to have_content "0"
      end
    end
  end
  describe 'タスク詳細画面' do
    context '任意のタスク詳細画面に遷移した場合' do
      it '該当タスクの内容が表示されたページに遷移する' do
        # binding.pry
        visit task_path(id: 1)
        expect(page).to have_content 'sampleタイトル1'
        expect(page).to have_content 'sampleコンテント1'
        expect(page).to have_content '2020年06月20日'
        expect(page).to have_content '未着手'
        expect(page).to have_content 'High'
        expect(page).to have_content "0"
      end
    end
  end
  DatabaseCleaner.clean
end