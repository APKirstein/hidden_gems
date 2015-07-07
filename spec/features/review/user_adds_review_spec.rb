require 'rails_helper'

feature 'user adds a review', %{
  As an authenticated user
  I want to add a review for a restaurant
  So that I can share with others my thoughts about that restaurant
} do

  # Acceptance Criteria
  # [x] I must be signed in
  # [x] If user is not signed in, user will be prompted to sign in
  # [x] My review must include ratings for all 4 key attributes
  # [x] I can leave an optional comment
  # [x] When I submit my review, I can see it on the restaurant's detail page
  # [x] I must be presented with errors if I leave an invalid review
  # [x] If all is good, I get a successfully submitted message

  # value: Not Worth It - 2 - 3 - 4 - Worth It
  # proximity: Middle of Nowhere - 2 - 3 - 4 - Right Next Door
  # volume: Needed to Scream - 2 - 3 - 4 - Didn't need to repeat myself
  # originality: Same Old, Same Old - 2 - 3 - 4 - Telling All My Friends
  let!(:restaurant) { FactoryGirl.create(:restaurant) }
  let!(:user) { FactoryGirl.create(:user) }

  context "user is signed in" do
    scenario 'user adds a review with comment from restaurant detail page' do
      sign_in_as(user)
      visit restaurant_path(restaurant)

      select '2', from: "review_value"
      select '3', from: "review_proximity"
      select '4', from: "review_volume"
      select 3, from: "review_originality"
      fill_in 'review_body', with: 'Textytexttext'

      click_button 'Submit'

      expect(page).to have_content(restaurant.name)
      expect(page).to have_content("Value: 2")
      expect(page).to have_content("Proximity: 3")
      expect(page).to have_content("Volume: 4")
      expect(page).to have_content("Originality: 3")
      expect(page).to have_content("Textytexttext")
      expect(page).to have_content("Thanks for your review!")
    end

    scenario 'user adds a review without comment from restaurant detail page' do
      sign_in_as(user)
      visit restaurant_path(restaurant)

      select 'worth it', from: "review_value"
      select 'right next door', from: "review_proximity"
      select 'needed to scream', from: "review_volume"
      select 3, from: "review_originality"

      click_button 'Submit'

      expect(page).to have_content(restaurant.name)
      expect(page).to have_content("5")
      expect(page).to have_content("5")
      expect(page).to have_content("1")
      expect(page).to have_content("3")
      expect(page).to have_content("Thanks for your review!")
    end

    scenario 'user adds a review without filling out all fields' do
      sign_in_as(user)
      visit restaurant_path(restaurant)

      select 'worth it', from: "review_value"
      select 'right next door', from: "review_proximity"
      select 'needed to scream', from: "review_volume"

      click_button 'Submit'

      expect(page).to have_content(restaurant.name)
      expect(page).to have_content("can't be blank")
    end
  end

  context "user is not signed in" do
    let!(:restaurant) { FactoryGirl.create(:restaurant) }
    scenario 'visitor tries to visit a show page' do

      visit restaurant_path(restaurant)

      expect(page).to have_content(restaurant.address)
      expect(page).to have_content('Sign In')
    end
  end

end
