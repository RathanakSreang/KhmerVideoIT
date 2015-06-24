# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
50.times do
  Video.create title: Faker::Lorem.word,
                description: Faker::Lorem.paragraph,
                duration: 10,
                remote_image_url: Faker::Avatar.image("screenshot.png", "50x50")
end

Video.all.each do |video|
  5.times do
    video.usefull_links.create title: Faker::Lorem.sentence,
                              link: Faker::Internet.url
  end

  video.create_article content: Faker::Lorem.paragraph(10)
end
