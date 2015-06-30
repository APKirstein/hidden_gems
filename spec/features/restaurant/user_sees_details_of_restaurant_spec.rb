require 'rails_helper'

feature 'user views details of a restaurant', %{
  As a user
  I want to click on a restaurant name
  so I can see its details
} do

  # [ ] - I can click on a restaurant's name and get redirected
  # [ ] - I am redirected to the restaurant show page
  # [ ] - I can see the details of the restaurant

  restaurant =  FactoryGirl.create(:restaurant)

  scenario 'user visits the index page' do
    visit '/'

    click_link(restaurant.name)

    expect(page).to have_content(restaurant.name)
    expect(page).to have_content(restaurant.address)
    expect(page).to have_content(restaurant.city)
    expect(page).to have_content(restaurant.state)
  end
end
