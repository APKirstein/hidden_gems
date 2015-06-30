require 'rails_helper'

feature 'admin deletes a restaurant', %{
  As an admin
  I want to delete a restaurant
  so that no one can review it
} do

  # [ ] - Admin can see delete link
  # [ ] - Admin can click on delete link
  # [ ] - Admin sees all restaurants minus deleted

  # let(:restaurant) { FactoryGirl.build(:restaurant) }
  #
  # scenario 'admin delets a restaurant' do
  #   visit restaurants_path
  #   click_link("Delete")
  #
  #   expect(page).to have_content("Deleted")
  # end
end

# click_link("Delete")
# expect(page).to have_content("Deleted")
