require 'rails_helper'

feature 'user views list of all restaurants', %Q{
  As a user
  I want to visit the main page
  so I can see a list of all restaurants
} do

  # [ ] - I can navigate to the root page
  # [ ] - I can view a list of restaurants
  # [ ] - I can view restaurnts in ranked order

  restaurant = FactoryGirl.create(:restaurant)

  scenario 'user visits the index page' do
    visit '/'
    expect(page).to have_content(restaurant.name)
  end

  # restaurant_2 = FactoryGirl.create(:restaurant)
  # scenario 'user sees restaurants ordered by ranking' do
  #   visit '/'
  #   page.body.index(restaurant.name).should < page.body.index(restaurant_2.name)
  # end

end
