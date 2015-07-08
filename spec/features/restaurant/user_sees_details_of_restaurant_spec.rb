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

  before(:each) do
    50.times { FactoryGirl.create(:review, restaurant_id: restaurant.id) }
  end
  after(:each) do
    Review.delete_all
  end

  context "user is signed in" do
    scenario 'authenticated user visits the index page' do
      visit root_path
      sign_in_as(user)

      click_link(restaurant.name)

      expect(page).to have_content(restaurant.name)
      expect(page).to have_content(restaurant.address)
      expect(page).to have_content(restaurant.city)
      expect(page).to have_content(restaurant.state)

      click_link 'Next'

      uri = URI.parse(current_url)
      expect("#{uri.path}?#{uri.query}").to
      eq(restaurant_path(restaurant, page: '2'))
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

      click_link 'Next'

      uri = URI.parse(current_url)
      expect("#{uri.path}?#{uri.query}").to
      eq(restaurant_path(restaurant, page: '2'))
    end
  end
end
