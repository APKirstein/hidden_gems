require 'rails_helper'

feature 'user adds a review', %{
  As an authenticated user
  I want to add a review for a restaurant
  So that I can share with others my thoughts about that restaurant
} do

  # Acceptance Criteria
  # [] I must be signed in
  # [] If user is not signed in, user will be prompted to sign in
  # [] My review must include ratings for all 4 key attributes
  # [] I can leave an optional comment
  # [] When I submit my review, I can see it on the restaurant's detail page
  # [] I must be presented with errors if I leave an invalid review
  # [] If all is good, I get a successfully submitted message


  # value: Not Worth It - 2 - 3 - 4 - Worth It
  # proximity: Middle of Nowhere - 2 - 3 - 4 - Right Next Door
  # volume: Needed to Scream - 2 - 3 - 4 - Didn't need to repeat myself
  # originality: Same Old, Same Old - 2 - 3 - 4 - Telling All My Friends

  let!(:restaurant) = { FactoryGirl.create(:restaurant) }

  context "user is signed in" do
    let!(:user) = { FactoryGirl.create(:user) }

    before(:each) do
      visit new_user_session_path

      fill_in 'Email', with: user.email
      fill_in 'Password', with: user.password

      click_button 'Log in'
    end

    scenario 'user adds a review with comment from restaurant detail page' do
      visit restaurant_path(id: restaurant)

      choose 'Worth It'
      choose 'Right Next Door'
      choose 'Needed To Scream'
      choose '3'

      fill_in 'Comments', with: 'Textytexttext'

      click_button 'Submit'

      expect(page).to have_content(restaurant.name)
      expect(page).to have_content("5")
      expect(page).to have_content("5")
      expect(page).to have_content("1")
      expect(page).to have_content("3")
      expect(page).to have_content("Textytexttext")
      expect(page).to have_content("Thanks for your review!")
    end

    scenario 'user adds a review without comment from restaurant detail page' do
      visit restaurant_path(id: restaurant)

      choose 'Worth It'
      choose 'Right Next Door'
      choose 'Needed To Scream'
      choose '3'

      click_button 'Submit'

      expect(page).to have_content(restaurant.name)
      expect(page).to have_content("5")
      expect(page).to have_content("5")
      expect(page).to have_content("1")
      expect(page).to have_content("3")
      expect(page).to have_content("Thanks for your review!")
    end

    scenario 'user adds a review without filling out all fields' do
      visit restaurant_path(id: restaurant)

      choose 'Worth It'
      choose '2'
      choose 'Needed To Scream'
      expect(page).to have_content("Textytexttext")

      click_button 'Submit'

      expect(page).to have_content(restaurant.name)
      page.find_field('Comments').set("Textytexttext")
      page.find_field("Worth It").should be_checked
      page.find_field("2").should be_checked
      expect(page).to have_content("You must complete all ratings!")
    end
  end

  context "user is not signed in" do
    visit restaurant_path(id: restaurant)

    expect(page).to have_content(restaurant.address)
    expect(page).to have_contenct('Sign in')
    expect(page).to_not have_content("Worth it")
  end
end
