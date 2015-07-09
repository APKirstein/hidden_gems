require 'rails_helper'

feature 'user adds a new restaurant', %{
  As a user
  I want to visit the new restaurant page
  so I can add a new restaurant
} do

  # [x] - I can navigate to the restaurants/new page
  # [x] - I can create a new restaurant
  # [x] - I am redirected to the restaurants index page

  let!(:restaurant) { FactoryGirl.build(:restaurant) }
  let!(:user) { FactoryGirl.create(:user) }

  context 'user is signed in' do
    # valid test
    scenario 'authenticated user submits a new restaurant' do
      sign_in_as(user)
      visit new_restaurant_path

      fill_in('Name', with: restaurant.name)
      fill_in('Address', with: restaurant.address)
      fill_in('City', with: restaurant.city)
      fill_in('State', with: restaurant.state)
      fill_in('Zip', with: restaurant.zip_code)

      click_button('Add Restaurant')

      expect(page).to have_content(restaurant.name)

    end

    # invalid test
    scenario 'user submits an invalid restaurant' do
      save_and_open_page
      sign_in_as(user)
      visit new_restaurant_path

      fill_in('Name', with: "")
      fill_in('Address', with: restaurant.address)
      fill_in('City', with: restaurant.city)
      fill_in('State', with: restaurant.state)
      fill_in('Zip', with: restaurant.zip_code)

      click_button('Add Restaurant')

      expect(page).to have_content("Name can't be blank")
    end
  end

  context 'user is not signed in' do
    # unauthorized user
    scenario 'unauthenticated user cannot submit a new restaurant' do
      visit new_restaurant_path
      expect(page).to have_content("You need to sign in or sign up before")
    end
  end
end
