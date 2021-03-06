# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
user1 = User.new name: "RathanakSuper",
                email: "sreangrathanak@gmail.com",
                password: "1234567890",
                password_confirmation: "1234567890",
                role: :super
user1.skip_confirmation!
user1.save!
user = User.new name: "RathanakAdmin",
                email: "sreang@yoo.comddddd1",
                password: "1234567890",
                password_confirmation: "1234567890",
                role: :admin
user.skip_confirmation!
user.save!
5.times do
  user = User.new name: Faker::Name.name,
              email: Faker::Internet.email,
              # remote_avatar_url: Faker::Avatar.image("avater.png", "64x64"),
              password: "1234567890",
              password_confirmation: "1234567890"
  user.skip_confirmation!
  user.save!
end

Page.create! content: Faker::Lorem.paragraph(10),
            title: Faker::Name.name

5.times do
  user1.tags.create! name: Faker::Name.name
end

# snnippet = Snippet.create content: Faker::Lorem.paragraph

10.times do
  tag_ids = Tag.pluck :id
  user1.videos.create! title: Faker::Lorem.word,
              description: Faker::Lorem.paragraph,
              duration: 10,
              file_link: "https://www.youtube.com/watch?v=kBdZ9_yGLjg",
              tag_ids: tag_ids,
              status: true
end

Video.all.each do |video|
  video.create_snippet! content: Faker::Lorem.paragraph(10)
end

5.times do
  tag_ids = Tag.pluck :id
  user1.articles.create! title: Faker::Lorem.sentence,
                  content: Faker::Lorem.paragraph(10),
                  tag_ids: tag_ids,
                  status: true
end
