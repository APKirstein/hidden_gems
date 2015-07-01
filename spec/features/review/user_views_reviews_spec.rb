require 'rails_helper'

feature 'user sees all reviews for a restaurant', %{
  As a user
  I want to see all the reviews for a restaurant
  So that I can decide if I'd want to have a date there
} do

  # Acceptance Criteria
  # [] I do not need to be an authenticated user
  # [] I can see all the reviews on the restaurant's details page


  # value: Not Worth It - 2 - 3 - 4 - Worth It
  # proximity: Middle of Nowhere - 2 - 3 - 4 - Right Next Door
  # volume: Needed to Scream - 2 - 3 - 4 - Didn't need to repeat myself
  # originality: Same Old, Same Old - 2 - 3 - 4 - Telling All My Friends

  let!(:restaurant) { FactoryGirl.create(:restaurant) }
  let!(:review) { FactoryGirl.create(:review, restaurant_id: restaurant.id,
    comment: "This review has a comment") }

  context "authenticated user is signed in" do
    let!(:user) { FactoryGirl.create(:user) }

    before(:each) do
      visit new_user_session_path

      fill_in 'Email', with: user.email
      fill_in 'Password', with: user.password

      click_button 'Log in'
    end

    scenario "user sees a list of reviews for a restaurant" do
      visit restaurant_path(id: restaurant)

      expect(page).to have_content(review.comment)
      expect(page).to have_content("Value: #{review.value}")
    end
  end

  context "user is not signed in" do
    scenario "unauthenticated user sees a list of reviews for a restaurant" do
      visit restaurant_path(id: restaurant)

      expect(page).to have_content(review.comment)
      expect(page).to have_content("Value: #{review.value}")
    end
  end
end
