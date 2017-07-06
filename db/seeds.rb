# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
100.times do |_|
  title = Faker::Book.title
  description = Faker::Lorem.sentence
  price = Faker::Number.number(2)
  Book.create!(title: title,
               description: description,
               price: price
  )
end
