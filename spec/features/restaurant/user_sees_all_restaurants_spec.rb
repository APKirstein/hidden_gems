require 'rails_helper'

feature 'user views list of all restaurants', %Q{
  As a user
  I want to visit the main page
  so I can see a list of all restaurants
} do

  # [ ] - I can navigate to the root page
  # [ ] - I can view a list of restaurants
  # [ ] - I can view restaurnts in ranked order

  let(:restaurant) { FactoryGirl.create(:restaurant) }
  let(:restaurant_2) { FactoryGirl.create(:restaurant) }

  scenario 'user visits the index page' do
    restaurant.save
    visit '/'
    expect(page).to have_content(restaurant.name)
  end

  scenario 'user sees restaurants ordered by ranking' do
    restaurant_2.save
    visit '/'
    page.body.index(restaurant_2.name).should < page.body.index(restaurant.name)
  end

end
