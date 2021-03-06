FactoryBot.define do
  factory :user do
    id { 1 }
    user_name { 'sample' }
    email { 'sample@example.com' }
    password { '00000000' }
    admin { false }
  end
  factory :admin_user, class: User do
    id { 2 }
    user_name { 'admin' }
    email { 'admin@example.com' }
    password { '00000000' }
    admin { true }
  end
  factory :second_user, class: User do
    id { 3 }
    user_name { 'sample2' }
    email { 'sample2@example.com' }
    password { '00000000' }
    admin { false }
  end
  factory :third_user, class: User do
    id { 4 }
    user_name { 'sample3' }
    email { 'sample3@example.com' }
    password { '00000000' }
    admin { false }
  end
end
