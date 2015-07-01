# require 'rails_helper'
#
# feature 'visitor views list of all restaurants', %Q{
#   As a user
#   I want to visit the main page
#   so I can see a list of all restaurants
# } do
#
#   # [ ] - I can navigate to the root page
#   # [ ] - I can view a list of restaurants
#   # [ ] - I can view restaurnts in ranked order
#
#   let(:restaurant) { Restaurant.create!(name: "Chipotle",
#   address: "33 Harrison Ave", city: "Boston", state: "MA") }
#
#   scenario 'user visits the index page' do
#     visit '/'
#     expect(page).to have_content(restaurant.name)
#     expect(page).to have_content(restaurant.address)
#     expect(page).to have_content(restaurant.city)
#     expect(page).to have_content(restaurant.state)
#   end
#
#   scenario 'user sees restaurants ordered by ranking' do
#     skip
#   end
# end
