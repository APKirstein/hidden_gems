require 'rails_helper'

feature 'user views list of all restaurants', %{
  As a user
  I want to visit the main page
  so I can see a list of all restaurants
} do

  # [x] - I can navigate to the root page
  # [x] - I can view a list of restaurants
  # [x] - I can view restaurnts in ranked order
  let!(:restaurant) { FactoryGirl.create(:restaurant) }

  scenario 'user visits the index page' do
    visit '/'
    expect(page).to have_content(restaurant.name)
  end

end
