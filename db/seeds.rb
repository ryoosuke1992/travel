User.create!(name:  "山田 太郎",
            email: "sample@example.com",
            password:              "foobar",
						password_confirmation: "foobar",
						admin: true)

99.times do |n|
 name  = Faker::Name.name
 email = "sample-#{n+1}@example.com"
 password = "password"
 User.create!(name:  name,
              email: email,
              password:              password,
              password_confirmation: password)
end

10.times do |n|
  title = Faker::Book.title
  Plan.create!(    
  title: title,
  date: "2021年4月1日",
  place: "ハワイ",
  meeting_place: "ハワイ空港",
  meeting_time: "13:00",
  content: "ハワイの綺麗な海を一緒に眺めましょう！",
  user_id: 1)
end

users = User.all
user  = users.first
following = users[2..50]
followers = users[3..40]
following.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) }