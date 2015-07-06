require 'rails_helper'

feature 'admin deletes restaurant', %{
  As an administrator of Date Bites
  I want to delete a restaurant
  So that I can remove closed restaurants from the site.
} do

  # Acceptance Criteria:
  # [] I must be logged in as an admin; if I am not, I receive an error and then
  # redirected to the home page
  # [] I can delete a restaurant by visiting admin/restaurants and clicking on a delete
  # link next to the entry associated to the restaurant
  # [] I receive a confirmation when a restaurant has been deleted
  # [] After deleting a restaurant, I am redirected to the admin/restaurants page

  let!(:admin) { FactoryGirl.create(:user, role: 'admin') }
  let!(:restaurant) { FactoryGirl.create(:restaurant) }

  scenario 'admin deletes restaurants' do
    sign_in_as(admin)
    visit '/admin/restaurants'

    page.click_link("Delete", href: "/admin/restaurants/#{restaurant.id}")

    expect(page).to have_content("Successfully deleted #{restaurant.name}!")
    expect(page).to_not have_content(restaurant.address)
  end

  scenario 'unauthorized users are redirected' do
    user = FactoryGirl.create(:user)
    sign_in_as(user)
    visit '/admin/restaurants'

    expect(page).to have_content('not authorized')
    expect(current_path).to eq(root_path)
  end
end
