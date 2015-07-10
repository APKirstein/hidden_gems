# require 'rails_helper'
#
# feature 'visitor edits details of a created restaurant', %{
#   As an authenticated user
#   I want to update a restaurant
#   So that I can keep the address up to date
# } do
#
#   # Acceptance Criteria
#   # [] Authenticated user can go to show page and see edit button
#   # [] Unauthenticate user can go to show page but not see edit button
#   # [] User can validly edit the restaurant information and get a success flash
#   # [] If user submits invalid information they are given errors
#
#   let!(:user) { FactoryGirl.create(:user) }
#   let!(:restaurant) { FactoryGirl.create(:restaurant) }
#
#   context "authenticated user" do
#     scenario "user navigates to edit page and updates restaurant information" do
#       sign_in_as(user)
#
#       visit restaurant_path(restaurant)
#
#       click_link "Edit Restaurant"
#
#       fill_in "Name", with: "This is a new Restuarant Name!!! :D Wheeee"
#
#       click_button "Submit Changes"
#
#       expect(page).to have_content("Wheeee")
#       expect(page).to have_content("Changes saved successfully")
#     end
#
#     scenario "user navigates to edit page and invalidly tries to update" do
#       sign_in_as(user)
#
#       visit restaurant_path(restaurant)
#
#       click_link "Edit Restaurant"
#
#       fill_in "Name", with: ""
#
#       click_button "Submit Changes"
#
#       expect(page).to have_content("Name can't be blank")
#     end
#   end
#
#   context "unauthenticated user" do
#     scenario "user navigates to edit page " do
#       visit restaurant_path(restaurant)
#
#       expect(page).to_not have_content("Edit Restaurant")
#     end
#   end
# end
