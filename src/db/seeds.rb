# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
2.times do |n|
  User.create!(name:  "Example#{n+1}_User",
             email: "example#{n+1}@railstutorial.org",
             password:              "foobar",
             password_confirmation: "foobar",
             admin:     true,
             activated: true,
             activated_at: Time.zone.now)
end

#リプライ
user = User.find_by(name:"Example2_User")
micropost = user.microposts.create!(content: "@Example1_User ok?")
Replay.create!(replay_to:"Example1_User",replay_from:"Example2_User",
              micropost_id:micropost.id)

99.times do |n|
  name  = Faker::Name.name.gsub!(" ","_")
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  User.create!(name:  name,
              email: email,
              password:              password,
              password_confirmation: password,
              activated: true,
              activated_at: Time.zone.now)
end

# マイクロポスト
users = User.order(:created_at).take(6)
50.times do
  content = Faker::Lorem.sentence(word_count: 5)
  users.each { |user| user.microposts.create!(content: content) }
end

# リレーションシップ
users = User.all
user  = users.first
following = users[2..50]
followers = users[3..40]
following.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) }