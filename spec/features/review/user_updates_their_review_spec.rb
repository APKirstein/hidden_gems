require 'rails_helper'

feature 'user updates their review', %{
  As an authenticated user
  I want to be able to changed my review
  To reflect any new feelings I might have about a restaurant
} do

  # Acceptance Criteria
  # [] I must be signed in
  # [] If I'm not signed in, I should be prompted to do so
  # [] I can only edit my own reviews
  # [] The Edit Review form is autofilled with my original review/rating
  # [] When I submit my changes, I can see them on the restaurant's detail page
  # [] I get a successfully updated message

  # value: Not Worth It - 2 - 3 - 4 - Worth It
  # proximity: Middle of Nowhere - 2 - 3 - 4 - Right Next Door
  # volume: Needed to Scream - 2 - 3 - 4 - Didn't need to repeat myself
  # originality: Same Old, Same Old - 2 - 3 - 4 - Telling All My Friends

  let!(:restaurant) { FactoryGirl.create(:restaurant) }

  context "user is signed in" do
    let!(:user) { FactoryGirl.create(:user) }

    before(:each) do
      visit new_user_session_path

      fill_in 'Email', with: user.email
      fill_in 'Password', with: user.password

      click_button 'Log in'
    end

    scenario 'an authenticated user wants to update their review' do
      let!(:review) { FactoryGirl.create(:review, restaurant_id: restaurant.id,
        user_id: user.id) }

      visit restaurant_path(id: restaurant)

      click_link "Edit Review"

      choose "3"
      fill_in "Comments", with: "This is a new, edited comment!"

      click_button "Submit changes"

      expect(page).to have_content("This is a new, edited comment!")
      expect(page).to have_content("Your changes have been saved!")
    end

    scenario "an authenticated user cannot update another user's review" do
      let!(:review) { FactoryGirl.create(:review, restaurant_id: restaurant.id,
        user_id: (user.id + 1)) }

      visit restaurant_path(id: restaurant)

      expect(page).to_not have_content("Edit Review")
    end
  end

  context "user is not signed in" do
    scenario "an unauthenticated user cannot update any reviews" do
      let!(:review) { FactoryGirl.create(:review,
        restaurant_id: restaurant.id) }

      visit restaurant_path(id: restaurant)

      expect(page).to_not have_content("Edit Review")
    end
  end
end
