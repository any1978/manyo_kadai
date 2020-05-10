require 'rails_helper'

RSpec.describe 'タスク管理機能', type: :model do

  it 'titleが空ならバリデーションが通らない' do
    task = Task.new(name: '', description: '失敗テスト')
    expect(task).not_to be_valid
  end
  it 'contentが空ならバリデーションが通らない' do
    task = Task.new(name: '失敗タイトル', description: '')
    expect(task).not_to be_valid
  end
  it '全ての内容が記載されていればバリデーションが通る' do
    task = Task.new(name: '失敗タイトル', description: '失敗テスト', end_date: '2020-05-18 00:00:00 +0900', status: '着手中', priority: 0)
    expect(task).to be_valid
  end


  context 'scopeメソッドで検索をした場合' do
    before do
      @task1 = create(:task, name: "task1", description: '失敗テスト1', end_date: '2020-05-18 00:00:00 +0900', status: '着手中', priority: 0)
      @task2 = create(:second_task, name: "task2", description: '失敗テスト2', end_date: '2020-05-20 00:00:00 +0900', status: '着手中', priority: 0)
      task_list = all('.task_row') 
    end
    it "scopeメソッドでタイトル検索ができる" do
      tasks = Task.name
      expect(Task.get_by_name('task').count).to eq 2
    end
    it "scopeメソッドでステータス検索ができる" do
      expect(Task.get_by_status('着手中').count).to eq 2
    end
    it "scopeメソッドでラベル検索ができる" do
      @label1 = create(:label1)
      @label2 = create(:label2)
      Labelling.create(task_id: @task1.id, label_id: @label1.id)
      Labelling.create(task_id: @task2.id, label_id: @label2.id)
      expect(Task.search_with_label(@label1).count).to eq 1
    end
    it "scopeメソッドでタイトル&ステータス&ラベルの絞り込み検索ができる" do
      @label1 = create(:label1)
      @label2 = create(:label2)
      Labelling.create(task_id: @task1.id, label_id: @label1.id)
      Labelling.create(task_id: @task2.id, label_id: @label2.id)
      expect(Task.get_by_name('task').count).to eq 2
      expect(Task.get_by_status('着手中').count).to eq 2
      expect(Task.search_with_label(@label1).count).to eq 1
    end
  end
end