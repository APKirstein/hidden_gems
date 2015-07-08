# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

user = User.find_or_create_by(email: "rovaira@gmail.com")
user.update_attributes!(
  username: "rovaira",
  password: "testtest",
  password_confirmation: "testtest",
  role: "admin"
  )

restaurant = Restaurant.find_or_create_by(name: "Chipotle")
restaurant.update_attributes!(
  address: "33 Harrison Ave",
  city: "Boston",
  state: "MA",
  zip_code: "20111"
  )
