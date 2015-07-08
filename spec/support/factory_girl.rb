require 'factory_girl'

FactoryGirl.define do
  factory :user do
    sequence(:username) { |n| "username#{n}" }
    sequence(:email) { |n| "user#{n}@example.com" }
    password 'password'
    password_confirmation 'password'
  end

  factory :restaurant do
    sequence(:name) { |n| Faker::Company.name + "#{n}" }
    address Faker::Address.street_address
    city Faker::Address.city
    state Faker::Address.state_abbr
    zip_code Faker::Address.zip_code
  end

  factory :review do
  user
  restaurant
  value 2
  proximity 3
  volume 4
  originality 5
  body "Dododooo we left a comment!"
  end
end
