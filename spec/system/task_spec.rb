require 'rails_helper'

RSpec.describe 'タスク管理機能', type: :system do
  before do
    # あらかじめタスク一覧のテストで使用するためのタスクを二つ作成する
    @task1 = create(:task, name: '付け加えた名前', description: '付け加えたコンテント1', end_date: '2020/05/10', status: '着手中', priority: 'High')
    @task2 = create(:second_task, name: '付け加えた名前2', description: '付け加えたコンテント2', end_date: '2020/05/15', status: '着手中', priority: 'Middle')
    @task3 = create(:second_task, name: '付け加えた名前３', description: '付け加えたコンテント3', end_date: '2020/05/20', status: '着手中', priority: 'Low')
    @task4 = create(:task, name: '付け加えた名前4', description: '付け加えたコンテント4',end_date: '2020/05/25', status: '着手中', priority: 'High')
  end
  describe 'タスク一覧画面' do
    context 'タスクを作成した場合' do
      it '作成済みのタスクが表示される' do
        visit tasks_path
        expect(page).to have_content '付け加えた名前'
      end
    end
    context '複数のタスクを作成した場合' do
      it 'タスクが作成日時の降順に並んでいる' do
        new_task = create(:task, name: 'new_task', end_date: '2020/05/19', status: '着手中', priority: 'Low')
        visit tasks_path
        task_list = all('.task_row') # タスク一覧を配列として取得するため、View側でidを振っておく
        # binding.irb
        expect(task_list[0]).to have_content 'new_task'
        expect(task_list[1]).to have_content '付け加えた名前4'
      end
    end
    context 'ソートボタンをクリックした場合' do
      it '終了期限の並び替えができる' do
        new_task = create(:task, name: 'Factoryで作ったデフォルトのタイトル1', end_date: '2020/05/30', status: '着手中', priority: 'Middle')
        visit tasks_path
        click_on "▲", match: :first
        expect(page).to have_content 'タスク一覧'
        task_list = all('.task_row') 
        expect(page).to have_content 'タスク一覧'
        expect(task_list[0]).to have_content '付け加えた名前'
        visit tasks_path
        click_on '▼', match: :first
        expect(page).to have_content 'タスク一覧'
        task_list = all('.task_row')
        expect(task_list[0]).to have_content 'Factoryで作ったデフォルトのタイトル1'
      end
    end
    context '検索をした場合' do
      before do
        create(:task, name: 'name', description: "task", end_date: '2020/06/30', status: '着手中', priority: 'Middle')
        create(:task, name: 'second_name', description: "sample", end_date: '2020/07/30', status: '着手中', priority: 'Low')
      end
      it "タイトルで検索できる" do
        visit tasks_path
        fill_in "タイトル", with: "付け加えた名前"
        click_on "検索"
      end
      it "ステータスで検索できる" do
        visit tasks_path
        select "未着手", from: "status"
        click_on "検索"
        expect(page).to have_content "未着手"
      end
      it "タイトル&ステータスで検索できる" do
        visit tasks_path
        fill_in "タイトル", with: "付け加えた名前"
        select "未着手", from: "status"
        click_on "検索"
        expect(page).to have_content '付け加えた名前',"未着手"
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
        click_button '登録する'
        expect(page).to have_content "task"
        expect(page).to have_content "2020年05月19日"
        expect(page).to have_content "未着手"
        expect(page).to have_content "High"
      end
    end
  end
  describe 'タスク詳細画面' do
    context '任意のタスク詳細画面に遷移した場合' do
      it '該当タスクの内容が表示されたページに遷移する' do
        task = FactoryBot.create(:task, name: 'task', description: 'description', end_date: Time.new(2020,5,12), status: '着手中', priority: 'Middle')
        visit task_path(task.id)
        expect(page).to have_content 'task'
        expect(page).to have_content 'description'
        expect(page).to have_content '2020年05月12日'
        expect(page).to have_content '着手中'
        expect(page).to have_content 'Middle'
      end
    end
  end
end