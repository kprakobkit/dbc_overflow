# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
#
10.times do
  question = Question.create(title: Faker::Lorem.sentence, content: Faker::Lorem.sentence, vote: rand(1..50))
  5.times do
    question.answers.create(title: Faker::Lorem.sentence, content: Faker::Lorem.sentence, vote: rand(1..60))
  end
end
