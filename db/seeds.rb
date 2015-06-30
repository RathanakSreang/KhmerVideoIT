# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Page.create about: Faker::Lorem.paragraph(10)

5.times do
  Tag.create name: Faker::Name.name
end

10.times do
  tag_ids = Tag.pluck :id
  Video.create title: Faker::Lorem.word,
              description: Faker::Lorem.paragraph,
              duration: 10,
              tag_ids: tag_ids,
              remote_image_url: Faker::Avatar.image("screenshot.png", "50x50")
end

Video.all.each do |video|
  5.times do
    video.usefull_links.create title: Faker::Lorem.sentence,
                              link: Faker::Internet.url
  end

  video.create_snippet content: Faker::Lorem.paragraph(10)
end

5.times do
  tag_ids = Tag.pluck :id
  Article.create title: Faker::Lorem.sentence,
                  content: Faker::Lorem.paragraph(10),
                  tag_ids: tag_ids
end


user = User.new name: "Rathanak",
                email: "sreang@yoo.comddddd",
                password: "1234567890",
                password_confirmation: "1234567890",
                role: :admin
user.skip_confirmation!
user.save
5.times do
  user = User.new name: Faker::Name.name,
              email: Faker::Internet.email,
              remote_avatar_url: Faker::Avatar.image("avater.png", "64x64"),
              password: "1234567890",
              password_confirmation: "1234567890"
  user.skip_confirmation!
  user.save
end
