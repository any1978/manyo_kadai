
FactoryBot.define do

  factory :task, class: Task do
    name { 'sampleタイトル1' }
    description { 'sampleコンテント1' }  
    end_date { Time.new(2020,6,20) }  
    status { '未着手' } 
    priority { 0 } 
    # label_name_id {1}
    # after(:create) do |article|
    #   article.categories << create(:category)
    user {} 
  end

  factory :second_task, class: Task do
    name { 'sampleタイトル2' }
    description { 'sampleコンテント2' }
    end_date { Time.new(2020,7,20) } 
    status { '着手中' } 
    priority { 1 } 
    user {} 
  end

  factory :third_task, class: Task do
    name { 'sampleタイトル3' }
    description { 'sampleコンテント3' }
    end_date { Time.new(2020,8,20) } 
    status { '完了' } 
    priority { 2 } 
    user {} 
  end
end
