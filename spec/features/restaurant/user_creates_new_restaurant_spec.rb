require 'rails_helper'

feature 'user adds a new restaurant', %{
  As a user
  I want to visit the new restaurant page
  so I can add a new restaurant
} do

  # [ ] - I can navigate to the restaurants/new page
  # [ ] - I can create a new restaurant
  # [ ] - I am redirected to the restaurants index page

  restaurant = FactoryGirl.build(:restaurant)

  #valid test
  scenario 'user visits the new page', focus: true do
    visit '/restauants/new'

    fill_in('Name', :with => restaurant.name)
    fill_in('Address', :with => restaurant.address)
    fill_in('City', :with => restaurant.city)
    fill_in('State', :with => restaurant.state)
    fill_in('Zip', :with => restaurant.zip_code)

    click_button('Add Restaurant')

    expect(page).to have_content(restaurant.name)

  end

  #invalid test
  scenario 'user sees restaurants ordered by ranking' do
    visit '/restauants/new'

    fill_in('Name', :with => restaurant.name)
    fill_in('Address', :with => restaurant.address)
    fill_in('City', :with => restaurant.city)
    fill_in('State', :with => restaurant.state)
    fill_in('Zip', :with => restaurant.zip_code)

    click_button('Add Restaurant')

    expect(page).to have_content("Error")
  end
end
