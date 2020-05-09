
FactoryBot.define do

  factory :task do
    name { 'Factoryで作ったデフォルトのタイトル1' }
    description { 'Factoryで作ったデフォルトのコンテント１' }  
    end_date { 'Factoryで作ったデフォルトのDate1' }  
    status { '着手中' } 
    user
  end

  factory :second_task, class: Task do
    name { 'Factoryで作ったデフォルトのタイトル２' }
    description { 'Factoryで作ったデフォルトのコンテント２' }
    end_date { 'Factoryで作ったデフォルトのDate2' } 
    status { '完了' } 
    user
  end
end
