require 'rails_helper'

feature 'user views details of a restaurant', %{
  As a user
  I want to click on a restaurant name
  so I can see its details
} do

  # [x] - I can click on a restaurant's name and get redirected
  # [x] - I am redirected to the restaurant show page
  # [x] - I can see the details of the restaurant
  let!(:restaurant) { FactoryGirl.create(:restaurant) }
  let!(:user) { FactoryGirl.create(:user) }

  context "user is signed in" do
    scenario 'authenticated user visits the index page' do
      visit root_path
      sign_in_as(user)

      click_link(restaurant.name)

      expect(page).to have_content(restaurant.name)
      expect(page).to have_content(restaurant.address)
      expect(page).to have_content(restaurant.city)
      expect(page).to have_content(restaurant.state)
    end
  end

  context "user is not signed in" do
    scenario 'unauthenticated user visits the index page' do
      visit root_path

      click_link(restaurant.name)

      expect(page).to have_content(restaurant.name)
      expect(page).to have_content(restaurant.address)
      expect(page).to have_content(restaurant.city)
      expect(page).to have_content(restaurant.state)
    end
  end
end
