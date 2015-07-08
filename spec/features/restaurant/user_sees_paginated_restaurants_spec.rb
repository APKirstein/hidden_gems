require 'rails_helper'

feature 'user views list of all paginated restaurants', %{
  As a user
  I want to visit the main page
  so I can see a list of all restaurants
} do

  # [x] - I can navigate to the root page
  # [x] - I can view a list of restaurants
  # [x] - I can view restaurants in ranked order
  # [X] - Restaurants are paginated

  let!(:restaurant) { FactoryGirl.create(:restaurant) }
  let!(:user) { FactoryGirl.create(:user) }

  before(:each) do
    50.times { FactoryGirl.create(:restaurant) }
  end

  context "user is signed in" do
    scenario 'authenticated user visits the index page' do
      visit root_path
      sign_in_as(user)
      click_link 'Next'

      uri = URI.parse(current_url)
      expect("#{uri.path}?#{uri.query}").to eq(root_path(page: '2'))
      expect(page).to_not have_content(restaurant.name)
    end
  end

  context "user is not signed in" do
    scenario 'unauthenticated user visits the index page' do
      visit root_path
      click_link 'Next'

      uri = URI.parse(current_url)
      expect("#{uri.path}?#{uri.query}").to eq(root_path(page: '2'))
      expect(page).to_not have_content(restaurant.name)
    end
  end
end
