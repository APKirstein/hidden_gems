require 'rails_helper'

feature 'user deletes their review', %{
  As an authenticated user
  I want to be able to delete my review
  Because I no longer want that review on the site
} do

  # [] I must be signed in
  # [] If I'm not signed in, I should be prompted to do so
  # [] I can only delete my own reviews
  # [] I delete by clicking on the delete button in the Edit Profile page
  # [] I am prompted to confirm the deletion
  # [] I get a successfully deleted message
  # [] I no longer see my review on the Restaurant's show page

  context "user is signed in" do
    let!(:restaurant) { FactoryGirl.create(:restaurant) }
    let!(:user) { FactoryGirl.create(:user) }
    
    scenario 'an authenticated user wants to delete their review' do
      sign_in_as(user)
      let!(:review) { FactoryGirl.create(:review, restaurant_id: restaurant.id,
        user_id: user.id) }

      visit restaurant_path(id: restaurant)

      click_link "Edit Review"

      click_button "Delete Review"

      expect(page).to_not have_content(review.comment)
      expect(page).to have_content("Your review has been deleted")
    end

  #   scenario "an authenticated user cannot delete another user's review" do
  #     let!(:review) { FactoryGirl.create(:review, restaurant_id: restaurant.id,
  #       user_id: (user.id + 1)) }
  #
  #     visit edit_review_path(id: review)
  #
  #     expect(page).to_not have_content("Delete Review")
  #   end
  end
  #
  # context "user is not signed in" do
  #   scenario "an unauthenticated user cannot delete any reviews" do
  #     let!(:review) { FactoryGirl.create(:review, restaurant: restaurant.id) }
  #
  #     visit edit_review_path(id: review)
  #
  #     expect(page).to_not have_content("Delete Review")
  #   end
  # end
end
