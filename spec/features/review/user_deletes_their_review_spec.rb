require 'rails_helper'

feature 'user deletes their review', %{
  As an authenticated user
  I want to be able to delete my review
  Because I no longer want that review on the site
} do

  # [x] I must be signed in
  # [x] I can only delete my own reviews
  # [x] I delete by clicking on the delete button in the Restaurant Show page
  # [x] I am prompted to confirm the deletion
  # [x] I get a successfully deleted message
  # [x] I no longer see my review on the Restaurant's show page

  let!(:restaurant) { FactoryGirl.create(:restaurant) }
  let!(:user) { FactoryGirl.create(:user) }
  let!(:user2) { FactoryGirl.create(:user) }

  context "user is signed in" do
    scenario 'an authenticated user wants to delete their review' do
      review = FactoryGirl.create(:review, restaurant: restaurant, user: user)

      sign_in_as(user)

      visit restaurant_path(restaurant)

      click_button "Delete Review"

      expect(page).to_not have_content(review.body)
      expect(page).to have_content("Your review has been deleted")
    end

    scenario "an authenticated user cannot delete another user's review" do
      review2 = FactoryGirl.create(:review, restaurant: restaurant, user: user2)

      sign_in_as(user)

      visit restaurant_path(restaurant)

      expect(page).to_not have_content("Delete Review")
      expect(page).to have_content(review2.body)
    end
  end

  context "user is not signed in" do
    scenario "an unauthenticated user cannot delete any reviews" do
      review3 = FactoryGirl.create(:review, restaurant: restaurant, user: user2)

      visit restaurant_path(restaurant)

      expect(page).to_not have_content("Delete Review")
      expect(page).to have_content(review3.body)
    end
  end
end
