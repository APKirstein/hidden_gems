require 'rails_helper'

feature 'admin deletes a restaurant', %{
  As an admin
  I want to delete a restaurant
  so that no one can review it
} do

  # Acceptance Criteria
  # [ ] - Admin can see delete link
  # [ ] - Admin can click on delete link
  # [ ] - Admin sees all restaurants minus deleted

  let(:restaurant) { FactoryGirl.create(:restaurant) }
  let(:user) { FactoryGirl.create(:user) }

  context "authenticated as a user" do
    scenario 'user deletes a restaurant' do
      sign_in_as(user)
      visit restaurant_path(restaurant)
      click_button "Delete"

      expect(page).to have_content("Deleted")
    end
  end

  context "unauthenticated as a user" do
    scenario 'user deletes a restaurant' do
      visit restaurant_path(restaurant)

      expect(page).to_not have_content("Delete")
    end
  end
end
