require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do
  before do
    # あらかじめタスク一覧のテストで使用するためのタスクを二つ作成する
    @task1 = create(:task)
    @task2 = create(:second_task)
    @task3 = create(:second_task, name: '付け加えた名前３', description: '付け加えたコンテント1', end_date: '2020/05/12')
    #「タスク一覧画面」や「タスク詳細画面」などそれぞれのテストケースで、before内のコードが実行される
    # 各テストで使用するタスクを1件作成する
    # 作成したタスクオブジェクトを各テストケースで呼び出せるようにインスタンス変数に代入
    @task4 = create(:task, name: 'task')
  end
  describe 'タスク一覧画面' do
    context 'タスクを作成した場合' do
      it '作成済みのタスクが表示される' do
        visit tasks_path
        expect(page).to have_content 'task'
      end
    end
    context '複数のタスクを作成した場合' do
      it 'タスクが作成日時の降順に並んでいる' do
        new_task = create(:task, name: 'new_task', end_date: '2020-05-19 00:00:00 +0900')
        visit tasks_path
        task_list = all('.task_row') # タスク一覧を配列として取得するため、View側でidを振っておく
        # binding.irb
        expect(task_list[0]).to have_content 'new_task'
        expect(task_list[1]).to have_content 'task'
      end
    end
    context 'ソートボタンをクリックした場合' do
      it '終了期限の並び替えができる' do
        new_task = create(:task, name: 'new_task', end_date: '2020-05-19 00:00:00 +0900')
        visit tasks_path
        click_on('▲') 
        task_list = all('.task_row') 
        # binding.irb
        # .click_link '▲'
        # save_and_open_page
        expect(task_list[0]).to have_content '付け加えた名前３'
        visit tasks_path
        click_on('▼') 
        task_list = all('.task_row')
        # .click_link '▼'
        expect(task_list[0]).to have_content 'Factoryで作ったデフォルトのタイトル1'
      end
    end
    context '検索をした場合' do
      before do
        FactoryBot.create(:task, title: "task")
        FactoryBot.create(:second_task, title: "sample")
      end
      it "タイトルで検索できる" do
        visit tasks_path
        # タスクの検索欄に検索ワードを入力する (例: task)
        # 検索ボタンを押す
        expect(page).to have_content 'task'
      end
    end
  end
  describe 'タスク登録画面' do
    context '必要項目を入力して、createボタンを押した場合' do
      it 'データが保存される' do
        visit new_task_path
        fill_in "Name", with: '玉ねぎ買う'
        fill_in "Description", with: '2個買う'
        fill_in "End date", with: 'Date'
        click_button '登録する'
        save_and_open_page
        expect(page).to have_content '玉ねぎ買う'
        # expect(page).to have_content '2020-05-19 00:00:00 +0900'
      end
    end
  end
  describe 'タスク詳細画面' do
    context '任意のタスク詳細画面に遷移した場合' do
      it '該当タスクの内容が表示されたページに遷移する' do
        task = FactoryBot.create(:task, name: 'task', description: 'description', end_date: '2020/05/12')
        visit task_path(task.id)
        expect(page).to have_content 'task'
      end
    end
  end
end