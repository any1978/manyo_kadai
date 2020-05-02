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
  it 'titleとcontentに内容が記載されていればバリデーションが通る' do
    task = Task.new(name: '失敗タイトル', description: '失敗テスト')
    expect(task).to be_valid
  end
  it '全ての内容が記載されていればバリデーションが通る' do
    task = Task.new(name: '失敗タイトル', description: '失敗テスト', end_date: DateTime.now, status: "完了", priority: "row")
    expect(task).to be_valid
  end


  context 'scopeメソッドで検索をした場合' do
    before do
      Task.create(name: "task", description: "sample_task")
      Task.create(name: "sample", description: "sample_sample")
    end
    it "scopeメソッドでタイトル検索ができる" do
      expect(Task.get_by_name('task').count).to eq 1
    end
    it "scopeメソッドでステータス検索ができる" do
      # ここに内容を記載する
    end
    it "scopeメソッドでタイトルとステータスの両方が検索できる" do
      # ここに内容を記載する
    end
  end



end