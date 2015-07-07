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

  context "user is signed in" do
    scenario 'an authenticated user wants to update their review' do
      user = FactoryGirl.create(:user)
      restaurant = FactoryGirl.create(:restaurant)
      FactoryGirl.create(:review, user: user, restaurant: restaurant)
      sign_in_as(user)

      visit restaurant_path(restaurant)
      click_link "Edit Review"

      select 'worth it', from: "review_value"
      fill_in "Body", with: "This is a new, edited comment!"

      click_button "Submit"

      expect(page).to have_content("This is a new, edited comment!")
      expect(page).to have_content("Your changes have been saved!")
    end

    let!(:user2) { FactoryGirl.create(:user) }
    let(:review) { FactoryGirl.create(:review, restaurant_id: restaurant.id, user_id: user2.id) }

    scenario "an authenticated user cannot update another user's review" do
      user = FactoryGirl.create(:user)
      restaurant = FactoryGirl.create(:restaurant)

      sign_in_as(user)

      visit restaurant_path(restaurant)

      expect(page).to_not have_content("Edit Review")
    end
  end

  context "user is not signed in" do
    scenario "an unauthenticated user cannot update any reviews" do
      restaurant = FactoryGirl.create(:restaurant)
      user = FactoryGirl.create(:user)
      FactoryGirl.create(:review, restaurant_id: restaurant.id,
                  user_id: user.id)

      visit restaurant_path(id: restaurant)

      expect(page).to_not have_content("Edit Review")
    end
  end
end
