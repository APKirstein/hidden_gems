# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create!(
  email: "rovaira@gmail.com",
  username: "rovaira",
  password: "testtest",
  password_confirmation: "testtest",
  role: "admin"
)

Restaurant.create!(
  name: "Chipotle",
  address: "33 Harrison Ave",
  city: "Boston",
  state: "MA",
  zip_code: "20111"
)
