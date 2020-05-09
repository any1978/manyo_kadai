# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create!(user_name: '管理者', 
            email: 'test@test.com', 
            password: 'test@test.com', 
            password_confirmation: 'test@test.com', 
            admin: true,
            created_at: "2020-05-01 02:33:34", 
            updated_at: "2019-05-02 02:33:34")

30.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  User.create!(user_name:  name,
              email: email,
              password:              password,
              password_confirmation: password)
end

%W(HTML CSS Ruby Rails PHP Java).each { |a| Label.create(label_name: a) }