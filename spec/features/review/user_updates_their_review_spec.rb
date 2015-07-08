require 'rails_helper'

feature 'user updates their review', %{
  As an authenticated user
  I want to be able to changed my review
  To reflect any new feelings I might have about a restaurant
} do

  # Acceptance Criteria
  # [x] I must be signed in
  # [x] If I'm not signed in, I should be prompted to do so
  # [x] I can only edit my own reviews
  # [x] The Edit Review form is autofilled with my original review/rating
  # [x] When I submit my changes, I can see them on the restaurant's detail page
  # [x] I get a successfully updated message
  # [x] When user not signed in, and tries to visit reviews/edit page, user is
  # redirected to sign in page

  let!(:user) { FactoryGirl.create(:user) }
  let!(:restaurant) { FactoryGirl.create(:restaurant) }
  let!(:review) {
    FactoryGirl.create(
      :review,
      restaurant: restaurant,
      user: user)
  }

  context "user is signed in" do
    scenario 'an authenticated user wants to update their review' do
      sign_in_as(user)

      visit restaurant_path(restaurant)
      click_link "Edit Review"

      select 'worth it', from: "review_value"
      fill_in "Body", with: "This is a new, edited comment!"

      click_button "Submit"

      expect(page).to have_content("This is a new, edited comment!")
      expect(page).to have_content("Your changes have been saved!")
    end

    scenario "an authenticated user cannot update another user's review" do
      user2 = FactoryGirl.create(:user)
      sign_in_as(user2)

      visit restaurant_path(restaurant)

      expect(page).to_not have_content("Edit Review")
      expect(page).to have_content(review.body)
    end
  end

  context "user is not signed in" do
    scenario "an unauthenticated user cannot update any reviews" do
      visit restaurant_path(restaurant)

      expect(page).to_not have_content("Edit Review")
      expect(page).to have_content(review.body)
    end

    scenario "an unauthenticated user tries to visit review edit url" do
      visit "/reviews/#{review.id}/edit"

      expect(page).to have_content('You need to sign in')
      expect(current_path).to eq(new_user_session_path)
    end
  end
end
