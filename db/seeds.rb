# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

tom = User.find_or_create_by!(email: "tom@example.com") do |user|
  user.name = "Tom"
  user.password = "password"
  user.profile_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-user1.jpg"), filename:"sample-user1.jpg")
end

jun = User.find_or_create_by!(email: "jun@example.com") do |user|
  user.name = "Jun"
  user.password = "password"
  user.profile_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-user2.jpg"), filename:"sample-user2.jpg")
end

Post.find_or_create_by!(pref: "岐阜県") do |post|
  post.title = "日帰り"
  post.body = "11時飛騨・高山、１２時お昼ごはん"
  post.user = tom
end

Post.find_or_create_by!(pref: "愛知県") do |post|
  post.title = "泊まり"
  post.body = "１７時チェックイン、９時チェックアウト"
  post.user = jun
end
